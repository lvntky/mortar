mortar_sources = files('mortar.asm')

mortar_bin = custom_target('mortar_bin',
    output: 'mortar.bin',
    input: mortar_sources,
    command: [nasm, '-f', 'bin', '-o', '@OUTPUT@', '@INPUT@'],
    build_by_default: true
)

test('run_qemu', find_program('qemu-system-x86_64'),
    args: ['-drive', 'format=raw,file=' + mortar_bin.full_path()],
    is_parallel: false
)
