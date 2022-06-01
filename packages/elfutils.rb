require 'package'

class Elfutils < Package
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  @_ver = '0.186'
  version @_ver
  license 'GPL-2+ or LGPL-3+'
  compatibility 'all'
  source_url "https://sourceware.org/elfutils/ftp/#{@_ver}/elfutils-#{@_ver}.tar.bz2"
  source_sha256 '7f6fb9149b1673d38d9178a0d3e0fb8a1ec4f53a9f4c2ff89469609879641177'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elfutils/0.186_armv7l/elfutils-0.186-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elfutils/0.186_armv7l/elfutils-0.186-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elfutils/0.186_i686/elfutils-0.186-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elfutils/0.186_x86_64/elfutils-0.186-chromeos-x86_64.tar.xz',
  })
  binary_sha256({
    aarch64: '25fd7d99e5e97024974439900d992919808a7a2cf611f958281a2f1c415e3046',
     armv7l: '25fd7d99e5e97024974439900d992919808a7a2cf611f958281a2f1c415e3046',
       i686: '40c9c1f6ec7ce7d632779d117ab4f704b6125224c8916c6e53150b807cf21520',
     x86_64: 'be351d1f3faacaf7fec9390486cf0b6cda2b96b9881470bc0c211a262c51717c',
  })

  depends_on 'libcurl'
  depends_on 'libmicrohttpd'

  def self.build
    # If debuginfod is disabled, gdb is broken.
    if ARCH == 'i686'
      system "./configure #{CREW_OPTIONS} --program-prefix='eu-' \
        --disable-libdebuginfod --disable-debuginfod"
    else
      system "./configure #{CREW_OPTIONS} --program-prefix='eu-'"
    end
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
