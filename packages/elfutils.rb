require 'package'

class Elfutils < Package
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  version '0.188'
  license 'GPL-2+ or LGPL-3+'
  compatibility 'all'
  source_url "https://sourceware.org/elfutils/ftp/#{version}/elfutils-#{version}.tar.bz2"
  source_sha256 'fb8b0e8d0802005b9a309c60c1d8de32dd2951b56f0c3a3cb56d21ce01595dff'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elfutils/0.188_armv7l/elfutils-0.188-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elfutils/0.188_armv7l/elfutils-0.188-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elfutils/0.188_i686/elfutils-0.188-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elfutils/0.188_x86_64/elfutils-0.188-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'da8ce7537065401f2e4bcfbc2a1d2984892957cb611783b539bb805d72db15e3',
     armv7l: 'da8ce7537065401f2e4bcfbc2a1d2984892957cb611783b539bb805d72db15e3',
       i686: 'cbe8e8134256de0d2b0d28f01012f74cc6cf2313340214909f9a7fddd5ee93f8',
     x86_64: '9952fb6d9c22cde9ac9ceb45363d8bd5f8cca2a7ee61a66ccfb063e9e4dca32e'
  })

  depends_on 'bz2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libarchive' # R
  depends_on 'curl' # R
  depends_on 'libmicrohttpd' # R
  depends_on 'sqlite' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

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
