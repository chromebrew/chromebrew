require 'package'

class Elfutils < Package
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  version '0.178'
  source_url 'https://sourceware.org/elfutils/ftp/0.178/elfutils-0.178.tar.bz2'
  source_sha256 '31e7a00e96d4e9c4bda452e1f2cdac4daf8abd24f5e154dee232131899f3a0f2'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xzutils'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-debuginfod"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
