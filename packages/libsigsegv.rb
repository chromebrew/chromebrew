require 'package'

class Libsigsegv < Package
  version '2.10'
  source_url 'ftp.gnu.org/gnu/libsigsegv/libsigsegv-2.10.tar.gz'
  source_sha1 'b75a647a9ebda70e7a3b33583efdd550e0eac094'

  # arm compiler doesn't recognize -m32 option, so I made binary for the ease of use
  binary_url({
    armv7l: "https://dl.dropboxusercontent.com/s/8tcvv9s16mmtdgs/libsigsegv-2.10-chromeos-armv7l.tar.xz",
  })
  binary_sha1({
    armv7l: "004a4c6500946c7585c6ef782c912e36a056d8df",
  })

  def self.build
    system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make check"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
