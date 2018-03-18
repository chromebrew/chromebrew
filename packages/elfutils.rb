require 'package'

class Elfutils < Package
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  version '0.170'
  source_url 'https://sourceware.org/elfutils/ftp/0.170/elfutils-0.170.tar.bz2'
  source_sha256 '1f844775576b79bdc9f9c717a50058d08620323c1e935458223a12f249c9e066'

  depends_on 'xzutils'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
