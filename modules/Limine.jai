//
// This file was auto-generated using the following command:
//
// jai first.jai
//

LIMINE_COMMON_MAGIC_0 :: 0xc7b1dd30df4c8b88;
LIMINE_COMMON_MAGIC_1 :: 0x0a82e883a194f07b;

limine_uuid :: struct {
    a: u32;
    b: u16;
    c: u16;
    d: [8] u8;
}

LIMINE_MEDIA_TYPE_GENERIC :: 0;
LIMINE_MEDIA_TYPE_OPTICAL :: 1;
LIMINE_MEDIA_TYPE_TFTP :: 2;

limine_file :: struct {
    revision:        u64;
    address:         *void;
    size:            u64;
    path:            *u8;
    cmdline:         *u8;
    media_type:      u32;
    unused:          u32;
    tftp_ip:         u32;
    tftp_port:       u32;
    partition_index: u32;
    mbr_disk_id:     u32;
    gpt_disk_uuid:   limine_uuid;
    gpt_part_uuid:   limine_uuid;
    part_uuid:       limine_uuid;
}

/* Boot info */

LIMINE_BOOTLOADER_INFO_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0xf55038d8e2a1202f, 0x279426fcf5f59740];

limine_bootloader_info_response :: struct {
    revision: u64;
    name:     *u8;
    version:  *u8;
}

limine_bootloader_info_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_bootloader_info_response;
}

/* Stack size */

LIMINE_STACK_SIZE_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0x224ef0460a8e8926, 0xe1cb0fc25f46ea3d];

limine_stack_size_response :: struct {
    revision: u64;
}

limine_stack_size_request :: struct {
    id:         [4] u64;
    revision:   u64;
    response:   *limine_stack_size_response;
    stack_size: u64;
}

/* HHDM */

LIMINE_HHDM_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0x48dcf1cb8ad2b852, 0x63984e959a98244b];

limine_hhdm_response :: struct {
    revision: u64;
    offset:   u64;
}

limine_hhdm_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_hhdm_response;
}

/* Framebuffer */

LIMINE_FRAMEBUFFER_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1,  0x9d5827dcd881dd75, 0xa3148604f6fab11b];

LIMINE_FRAMEBUFFER_RGB :: 1;

limine_video_mode :: struct {
    pitch:            u64;
    width:            u64;
    height:           u64;
    bpp:              u16;
    memory_model:     u8;
    red_mask_size:    u8;
    red_mask_shift:   u8;
    green_mask_size:  u8;
    green_mask_shift: u8;
    blue_mask_size:   u8;
    blue_mask_shift:  u8;
}

limine_framebuffer :: struct {
    address:          *void;
    width:            u64;
    height:           u64;
    pitch:            u64;
    bpp:              u16;
    memory_model:     u8;
    red_mask_size:    u8;
    red_mask_shift:   u8;
    green_mask_size:  u8;
    green_mask_shift: u8;
    blue_mask_size:   u8;
    blue_mask_shift:  u8;
    unused:           [7] u8;
    edid_size:        u64;
    edid:             *void;

    /* Response revision 1 */
    mode_count:       u64;
    modes:            **limine_video_mode;
}

limine_framebuffer_response :: struct {
    revision:          u64;
    framebuffer_count: u64;
    framebuffers:      **limine_framebuffer;
}

limine_framebuffer_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_framebuffer_response;
}

/* Terminal */

LIMINE_TERMINAL_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0xc8ac59310c2b0844, 0xa68d0c7265d38878];

LIMINE_TERMINAL_CB_DEC :: 10;
LIMINE_TERMINAL_CB_BELL :: 20;
LIMINE_TERMINAL_CB_PRIVATE_ID :: 30;
LIMINE_TERMINAL_CB_STATUS_REPORT :: 40;
LIMINE_TERMINAL_CB_POS_REPORT :: 50;
LIMINE_TERMINAL_CB_KBD_LEDS :: 60;
LIMINE_TERMINAL_CB_MODE :: 70;
LIMINE_TERMINAL_CB_LINUX :: 80;

LIMINE_TERMINAL_CTX_SIZE :: cast,trunc(u64)(-1);
LIMINE_TERMINAL_CTX_SAVE :: cast,trunc(u64)(-2);
LIMINE_TERMINAL_CTX_RESTORE :: cast,trunc(u64)(-3);
LIMINE_TERMINAL_FULL_REFRESH :: cast,trunc(u64)(-4);

LIMINE_TERMINAL_OOB_OUTPUT_GET :: cast,trunc(u64)(-10);
LIMINE_TERMINAL_OOB_OUTPUT_SET :: cast,trunc(u64)(-11);

LIMINE_TERMINAL_OOB_OUTPUT_OCRNL :: 1 << 0;
LIMINE_TERMINAL_OOB_OUTPUT_OFDEL :: 1 << 1;
LIMINE_TERMINAL_OOB_OUTPUT_OFILL :: 1 << 2;
LIMINE_TERMINAL_OOB_OUTPUT_OLCUC :: 1 << 3;
LIMINE_TERMINAL_OOB_OUTPUT_ONLCR :: 1 << 4;
LIMINE_TERMINAL_OOB_OUTPUT_ONLRET :: 1 << 5;
LIMINE_TERMINAL_OOB_OUTPUT_ONOCR :: 1 << 6;
LIMINE_TERMINAL_OOB_OUTPUT_OPOST :: 1 << 7;

limine_terminal_write :: #type (unknown0: *limine_terminal, unknown1: *u8, unknown2: u64) -> void #c_call;
limine_terminal_callback :: #type (unknown0: *limine_terminal, unknown1: u64, unknown2: u64, unknown3: u64, unknown4: u64) -> void #c_call;

limine_terminal :: struct {
    columns:     u64;
    rows:        u64;
    framebuffer: *limine_framebuffer;
}

limine_terminal_response :: struct {
    revision:       u64;
    terminal_count: u64;
    terminals:      **limine_terminal;
    write:          limine_terminal_write;
}

limine_terminal_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_terminal_response;
    callback: limine_terminal_callback;
}

/* Paging mode */

LIMINE_PAGING_MODE_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0x95c1a0edab0944cb, 0xa4e5cb3842f7488a];

LIMINE_PAGING_MODE_X86_64_4LVL :: 0;
LIMINE_PAGING_MODE_X86_64_5LVL :: 1;
LIMINE_PAGING_MODE_MAX :: LIMINE_PAGING_MODE_X86_64_5LVL;
LIMINE_PAGING_MODE_DEFAULT :: LIMINE_PAGING_MODE_X86_64_4LVL;

limine_paging_mode_response :: struct {
    revision: u64;
    mode:     u64;
    flags:    u64;
}

limine_paging_mode_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_paging_mode_response;
    mode:     u64;
    flags:    u64;
}

/* 5-level paging */

LIMINE_5_LEVEL_PAGING_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0x94469551da9b3192, 0xebe5e86db7382888];

limine_5_level_paging_response :: struct {
    revision: u64;
}

limine_5_level_paging_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_5_level_paging_response;
}

/* SMP */

LIMINE_SMP_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0x95a67b819a1b857e, 0xa0b61b723b6a73e0];

LIMINE_SMP_X2APIC :: 1 << 0;

limine_goto_address :: #type (unknown0: *limine_smp_info) -> void #c_call;

limine_smp_info :: struct {
    processor_id:   u32;
    lapic_id:       u32;
    reserved:       u64;
    goto_address:   limine_goto_address;
    extra_argument: u64;
}

limine_smp_response :: struct {
    revision:     u64;
    flags:        u32;
    bsp_lapic_id: u32;
    cpu_count:    u64;
    cpus:         **limine_smp_info;
}

limine_smp_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_smp_response;
    flags:    u64;
}

/* Memory map */

LIMINE_MEMMAP_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0x67cf3d9d378a806f, 0xe304acdfc50c3c62];

LIMINE_MEMMAP_USABLE :: 0;
LIMINE_MEMMAP_RESERVED :: 1;
LIMINE_MEMMAP_ACPI_RECLAIMABLE :: 2;
LIMINE_MEMMAP_ACPI_NVS :: 3;
LIMINE_MEMMAP_BAD_MEMORY :: 4;
LIMINE_MEMMAP_BOOTLOADER_RECLAIMABLE :: 5;
LIMINE_MEMMAP_KERNEL_AND_MODULES :: 6;
LIMINE_MEMMAP_FRAMEBUFFER :: 7;

limine_memmap_entry :: struct {
    base:   u64;
    length: u64;
    type:   u64;
}

limine_memmap_response :: struct {
    revision:    u64;
    entry_count: u64;
    entries:     **limine_memmap_entry;
}

limine_memmap_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_memmap_response;
}

/* Entry point */

LIMINE_ENTRY_POINT_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0x13d86c035a1cd3e1, 0x2b0caa89d8f3026a];

limine_entry_point :: #type () -> void #c_call;

limine_entry_point_response :: struct {
    revision: u64;
}

limine_entry_point_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_entry_point_response;
    entry:    limine_entry_point;
}

/* Kernel File */

LIMINE_KERNEL_FILE_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0xad97e90e83f1ed67, 0x31eb5d1c5ff23b69];

limine_kernel_file_response :: struct {
    revision:    u64;
    kernel_file: *limine_file;
}

limine_kernel_file_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_kernel_file_response;
}

/* Module */

LIMINE_MODULE_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0x3e7e279702be32af, 0xca1c4f3bd1280cee];

LIMINE_INTERNAL_MODULE_REQUIRED :: 1 << 0;

limine_internal_module :: struct {
    path:    *u8;
    cmdline: *u8;
    flags:   u64;
}

limine_module_response :: struct {
    revision:     u64;
    module_count: u64;
    modules:      **limine_file;
}

limine_module_request :: struct {
    id:                    [4] u64;
    revision:              u64;
    response:              *limine_module_response;

    /* Request revision 1 */
    internal_module_count: u64;
    internal_modules:      **limine_internal_module;
}

/* RSDP */

LIMINE_RSDP_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0xc5e77b6b397e7b43, 0x27637845accdcf3c];

limine_rsdp_response :: struct {
    revision: u64;
    address:  *void;
}

limine_rsdp_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_rsdp_response;
}

/* SMBIOS */

LIMINE_SMBIOS_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0x9e9046f11e095391, 0xaa4a520fefbde5ee];

limine_smbios_response :: struct {
    revision: u64;
    entry_32: *void;
    entry_64: *void;
}

limine_smbios_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_smbios_response;
}

/* EFI system table */

LIMINE_EFI_SYSTEM_TABLE_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0x5ceba5163eaaf6d6, 0x0a6981610cf65fcc];

limine_efi_system_table_response :: struct {
    revision: u64;
    address:  *void;
}

limine_efi_system_table_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_efi_system_table_response;
}

/* Boot time */

LIMINE_BOOT_TIME_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0x502746e184c088aa, 0xfbc5ec83e6327893];

limine_boot_time_response :: struct {
    revision:  u64;
    boot_time: s64;
}

limine_boot_time_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_boot_time_response;
}

/* Kernel address */

LIMINE_KERNEL_ADDRESS_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0x71ba76863cc55f63, 0xb2644a48c516a487];

limine_kernel_address_response :: struct {
    revision:      u64;
    physical_base: u64;
    virtual_base:  u64;
}

limine_kernel_address_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_kernel_address_response;
}

/* Device Tree Blob */

LIMINE_DTB_REQUEST :: u64.[LIMINE_COMMON_MAGIC_0, LIMINE_COMMON_MAGIC_1, 0xb40ddb48fb54bac7, 0x545081493f81ffb7];

limine_dtb_response :: struct {
    revision: u64;
    dtb_ptr:  *void;
}

limine_dtb_request :: struct {
    id:       [4] u64;
    revision: u64;
    response: *limine_dtb_response;
}
