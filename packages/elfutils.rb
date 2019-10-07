require 'package'

class Elfutils < Package
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  version '0.177'
  source_url 'https://sourceware.org/elfutils/ftp/0.177/elfutils-0.177.tar.bz2'
  source_sha256 'fa489deccbcae7d8c920f60d85906124c1989c591196d90e0fd668e3dc05042e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.177-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.177-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.177-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.177-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '515b7c9a5e8de3b1e073b1370e24a331616530a20f91348e291bc0c92ad431d5',
     armv7l: '515b7c9a5e8de3b1e073b1370e24a331616530a20f91348e291bc0c92ad431d5',
       i686: 'c255e8096b05af371ea1942058f4b5e4a31ba342e6dc1e3062931eb4656e1898',
     x86_64: '403d0304956f372da40af8b2af6e00f82ae8db203a782e9c3f48a8028d8f1b5c',
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
