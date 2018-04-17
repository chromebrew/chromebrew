require 'package'

class Elfutils < Package
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  version '0.170'
  source_url 'https://sourceware.org/elfutils/ftp/0.170/elfutils-0.170.tar.bz2'
  source_sha256 '1f844775576b79bdc9f9c717a50058d08620323c1e935458223a12f249c9e066'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.170-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.170-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.170-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elfutils-0.170-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3c5882a75b5c4bcd7dd3279df7198d13c59c91facdd4914f15d0a8d28f557031',
     armv7l: '3c5882a75b5c4bcd7dd3279df7198d13c59c91facdd4914f15d0a8d28f557031',
       i686: '8e2996b44d085b7bb335107f15d600428eeff79662df399e3e18f78b7d4849ba',
     x86_64: 'fad208a4c12d9b3bf9b75a607714fa132f11f3c16ac015de2857f0087fe7ce41',
  })

  depends_on 'xzutils'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
