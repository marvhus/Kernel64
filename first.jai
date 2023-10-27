#import "File";
#import "Basic";
#import "String";
#import "Process";
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
    options.use_custom_link_command = true;
    options.llvm_options.enable_split_modules = false;

    options.disable_redzone = true;
    options.stack_trace = true;

    options.array_bounds_check = .OFF;
    options.cast_bounds_check  = .OFF;
    options.null_pointer_check = .OFF;
    options.enable_bytecode_inliner = false;
    options.dead_code_elimination = .ALL;

    options.backend = .LLVM;

    {
        new_path: [..] string;
        array_add(*new_path, "modules/");
        array_add(*new_path, ..options.import_path);
        options.import_path = new_path;
    }

    {
        arguments: [..] string;
        array_add(*arguments, ..options.llvm_options.command_line);
        array_add(*arguments, "--relocation-model=pic");
        options.llvm_options.command_line = arguments;
    }

    options.llvm_options.target_system_triple = "x86_64-unknown-none-elf";

    set_build_options(options, w);

    compiler_begin_intercept(w);
    add_build_file("src/kernel.jai", w);

    while true {
        message := compiler_wait_for_message();
        if message.workspace != w break;
        if message.kind == .COMPLETE break;

        build_steps(message);
    }
    compiler_end_intercept(w);
}

build_steps :: (message: *Message) {
    if message.kind == {
        case .ERROR;
            print("\nKernel Compilation Failure! (exiting.)\n");
            exit(1);
        case .PHASE;
            phase_message := cast(*Message_Phase) message;
            phase := phase_message.phase;

            if phase == .READY_FOR_CUSTOM_LINK_COMMAND {
                link_kernel(message.workspace);
            }
    }
}

link_kernel :: (workspace: Workspace) {
    options := get_build_options(workspace);

    args := string.[
        "ld",
        sprint(".build/%_0_w3.o",
            options.output_executable_name),
        "-nostdlib",
        "-static",
        //"-pie",
        "--no-dynamic-linker",
        "-z", "text",
        "-z", "max-page-size=0x1000",
        "-T", "cfg/link.ld",
        "-o", sprint("%1/%2",
            options.output_path,
            options.output_executable_name),
    ];
    print("[CMD] %\n", join(..args, separator = " "));
    run_command(..args);

    // We're done
    compiler_custom_link_command_is_complete(workspace);
}

