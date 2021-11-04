require 'package'

class Elfutils < Package
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  @_ver = '0.185'
  version @_ver
  license 'GPL-2+ or LGPL-3+'
  compatibility 'all'
  source_url "https://sourceware.org/elfutils/ftp/#{@_ver}/elfutils-#{@_ver}.tar.bz2"
  source_sha256 'dc8d3e74ab209465e7f568e1b3bb9a5a142f8656e2b57d10049a73da2ae6b5a6'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elfutils/0.185_i686/elfutils-0.185-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elfutils/0.185_armv7l/elfutils-0.185-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elfutils/0.185_armv7l/elfutils-0.185-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elfutils/0.185_x86_64/elfutils-0.185-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: '6bc34ddc832c3b49ee3e0bf887fd64d15537f3641c42c190383ef7f51de7ff49',
    aarch64: '097278811aa6899156dd5fdf770e9d42b4e20e7214cdd011b1c0d0191b349da1',
     armv7l: '097278811aa6899156dd5fdf770e9d42b4e20e7214cdd011b1c0d0191b349da1',
     x86_64: '4a84025108de03a5bcaddf493af476887b37bd2cd8fe7cc28e1ae3aad449ab82'
  })

  def self.patch
    # See https://www.mail-archive.com/elfutils-devel@sourceware.org/msg03816.html
    @gccpatch = <<~GCCPATCHEOF
      diff --git a/src/elflint.c b/src/elflint.c
      index 85cc7833..35b40500 100644
      --- a/src/elflint.c
      +++ b/src/elflint.c
      @@ -3434,7 +3434,7 @@ buffer_pos (Elf_Data *data, const unsigned char *p)
         return p - (const unsigned char *) data->d_buf;
       }
      #{' '}
      -inline size_t
      +static inline size_t
       buffer_left (Elf_Data *data, const unsigned char *p)
       {
         return (const unsigned char *) data->d_buf + data->d_size - p;
    GCCPATCHEOF
    IO.write('gcc.patch', @gccpatch)
    system 'patch -Np1 -i gcc.patch'
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --program-prefix='eu-' \
      --disable-libdebuginfod \
      --disable-debuginfod"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
