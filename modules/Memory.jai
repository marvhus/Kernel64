#program_export
memcpy :: (dst: *void, src: *void, count: s64) #c_call {
    #asm {
        cld;

        src     === si;
        dst     === di;
        count   === c;
        rep_movs.b dst, src, count;
    }
}
#program_export
memcmp :: (a: *void, b: *void, count: s64) -> s16 #c_call {
    a1 := cast(*u8) a;
    b1 := cast(*u8) b;
    for 0..count-1 {
        if a1[it] != b1[it] {
            return a1[it] - b1[it];
        }
    }
    return 0;
}
#program_export
memset :: (target: *void, value: u8, count: s64) #c_call {
    #asm {
        cld;

        count   === c;
        target  === di;
        value   === a;
        rep_stos.b target, value, count;
    }
}
#program_export
memmove :: (dest: *void, src: *void, count: s64) -> *void #c_call {
    pdest := cast(*u8) dest;
    psrc  := cast(*u8) src;
    if src > dest {
        for 0..count-1 pdest[it] = psrc[it];
    } else
    if src < dest {
        for 0..count-1 pdest[it-1] = psrc[it-1];
    }

    return dest;
}


