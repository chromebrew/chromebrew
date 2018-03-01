require 'package'

class Libfrei0r < Package
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '1.6.0'
  source_url 'https://github.com/dyne/frei0r/archive/v1.6.0.tar.gz'
  source_sha256 '63cae9d20d23b9d9e1ffb3fa053295914417c3e005194c077a0753d04636831c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfrei0r-1.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfrei0r-1.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfrei0r-1.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfrei0r-1.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7da44d7ceab2124298d49e0079d85cf06aec5e0dc0cebf1464f7b5e01c8a57f3',
     armv7l: '7da44d7ceab2124298d49e0079d85cf06aec5e0dc0cebf1464f7b5e01c8a57f3',
       i686: 'd7af95c71eb57144caf739e0fce9a6e81a2329382e448c5a590a9f8692ed4078',
     x86_64: 'eb79f81a2d63d6ebaa67ea5018fa76f67e2dec36d34a6b3e9b964f0686205814',
  })

  depends_on 'cmake'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
