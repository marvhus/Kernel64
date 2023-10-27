#if false {
#import "Limine";
#import "Memory";

framebuffer_request := limine_framebuffer_request.{
    id = LIMINE_FRAMEBUFFER_REQUEST,
    revision = 0,
};

// Halt and catch fire function.
hcf :: () #no_context {
    #asm { cli; }
    while true #asm { hlt; }
}

#program_export
_start :: () #no_context {
    if framebuffer_request.response == null
    || framebuffer_request.response.framebuffer_count < 1 {
        hcf();
    }
    
    // Fetch the first framebuffer.
    framebuffer := framebuffer_request.response.framebuffers[0];
    
    // @NOTE we assume the framebuffer model is RGB with 32-bit pixels.
    for 0..99 {
        fb_ptr := cast(*u32) framebuffer.address;
        fb_ptr[it * (xx framebuffer.pitch / 4) + it] = 0xffffffff;
    } 

    // We're done, just hang
    hcf();
}
}

#program_export
_start :: () #no_context {
    vga := cast(*u8) 0xb8000;
    for cast([]u8) "Hello, Sailor!" {
        vga[it_index * 2] = it;
        vga[it_index * 2 + 1] = 0x0f;
    }

    #asm {
        cli;
        hlt;
    }
}
