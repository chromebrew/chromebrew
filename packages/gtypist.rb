require 'package'

class Gtypist < Package
  description 'Universal typing tutor.'
  homepage 'https://www.gnu.org/software/gtypist/index.html'
  version '2.9.5'
  compatibility 'all'
  source_url 'http://ftp.gnu.org/gnu/gtypist/gtypist-2.9.5.tar.xz'
  source_sha256 'c13af40b12479f8219ffa6c66020618c0ce305ad305590fde02d2c20eb9cf977'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtypist-2.9.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtypist-2.9.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtypist-2.9.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtypist-2.9.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '270d48de1bc66a8ef39e8d72435aa2c1528b4a8512a791817e44c8d64ebfc0e0',
     armv7l: '270d48de1bc66a8ef39e8d72435aa2c1528b4a8512a791817e44c8d64ebfc0e0',
       i686: '90b43aa2ee81dfc1005b15a04fea0cb302cbc22a14915a8b2eea069caf328603',
     x86_64: '6ff05a34f4ce9f20bb6dbaef93ff55ecdee9fe9c5ede12d39e561886469a4b7d',
  })

  depends_on "emacs" => :build
  depends_on "ncurses"
  depends_on "perl"

  def self.build
    system "autoreconf"
    system "./configure", "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "prefix=#{CREW_DEST_PREFIX}", "install"
    system "rm", "-f", "#{CREW_DEST_PREFIX}/share/info/dir"
  end
end
