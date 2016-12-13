require 'package'

class Ncurses < Package
  version '5.9'
  source_url 'ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz'
  source_sha1 '3e042e5f2c7223bffdaac9646a533b8c758b65b5'

  # arm has 5.9 ncurses library in system, so leave it as is
  binary_url({
    armv7l: "https://dl.dropboxusercontent.com/s/kut6emhlda9pbc9/dummy-1.0.0-chromeos-armv7l.tar.gz",
  })
  binary_sha1({
    armv7l: "049db60338a74d798e72afabe05097f3a4c4f7cd",
  })

  depends_on "diffutils"

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-debug --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
