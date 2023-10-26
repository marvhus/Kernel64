#import "File";
#import "Basic";
#import "Compiler";

#run {
    #if OS != .LINUX then assert(false);

    set_build_options_dc(.{do_output = false});

    compile_kernel();
}

compile_kernel :: () {
    print("\n=== Compiling Kernel ===\n");

    make_directory_if_it_does_not_exist("bin");

    w := compiler_create_workspace("Kernel64");
    options := get_build_options(w);
    options.output_executable_name = "kernel64";
    options.output_path = "bin";
    options.output_type = .EXECUTABLE;
    options.entry_point_name = "_start";

    options.disable_redzone = true;
    options.stack_trace = true;

    options.array_bounds_check = .OFF;
    options.cast_bounds_check  = .OFF;
    options.null_pointer_check = .OFF;
    options.enable_bytecode_inliner = false;
    options.dead_code_elimination = .ALL;

    options.backend = .LLVM;

    {
        arguments: [..] string;
        array_add(*arguments, .. options.additional_linker_arguments);
        array_add(*arguments, "-T", "cfg/link.ld");
//        array_add(*arguments, "text");
//        array_add(*arguments, "max-page-size=0x1000");
        options.additional_linker_arguments = arguments;
    }

//    options.llvm_options.target_system_triple = "x86_64-unknown-none-elf";
//    options.os_target = .NONE;

    set_build_options(options, w);

    compiler_begin_intercept(w);
    add_build_file("src/kernel.jai", w);

    linker_fail := false;
    while true {
        message := compiler_wait_for_message();
        if message.kind == {
            case .COMPLETE;
                break;
            case .ERROR;
                print("\nKernel Compilation Failure! (exiting.)\n");
                exit(1);
            case .PHASE;
                phase := cast(*Message_Phase) message;
                if phase.phase == .POST_WRITE_EXECUTABLE && phase.linker_exit_code != 0 {
                    print("\nIt appears there were linker errors. Cannot continue.\n");
                    linker_fail = true;
                }
        }
    }
    compiler_end_intercept(w);

    if linker_fail exit(1);;
}

