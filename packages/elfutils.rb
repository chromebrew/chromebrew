require 'package'

class Elfutils < Package
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  version '0.177'
  source_url 'https://sourceware.org/elfutils/ftp/0.177/elfutils-0.177.tar.bz2'
  source_sha256 'fa489deccbcae7d8c920f60d85906124c1989c591196d90e0fd668e3dc05042e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xzutils'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
