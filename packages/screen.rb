require 'package'

class Screen < Package
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '4.6.1'
  source_url 'ftp://ftp.gnu.org/gnu/screen/screen-4.6.1.tar.gz'
  source_sha256 'aba9af66cb626155d6abce4703f45cce0e30a5114a368bd6387c966cbbbb7c64'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/screen-4.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/screen-4.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/screen-4.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/screen-4.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3bdf1921afe853c19e697c6184dc219730f7ff467fe5618d68284d6bb02274ec',
     armv7l: '3bdf1921afe853c19e697c6184dc219730f7ff467fe5618d68284d6bb02274ec',
       i686: 'd37c45dafeca73dc2bb9532598791f4c12288c76a2786e7c371367e227b01047',
     x86_64: 'a021534a67a4c22c2ac6aa4ffe9c7ee52d3559f3b2020507beaa1a9347e29a97',
  })

  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
