require 'package'

class Libxkbfile < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.0.9-0'
  source_url 'https://www.x.org/archive/individual/lib/libxkbfile-1.0.9.tar.gz'
  source_sha256 '95df50570f38e720fb79976f603761ae6eff761613eb56f258c3cb6bab4fd5e3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbfile-1.0.9-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbfile-1.0.9-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbfile-1.0.9-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbfile-1.0.9-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0da685fe99dcbbe5f69daa717ea1938d6bf6fab3149cbc50cefbd14e68e3963a',
     armv7l: '0da685fe99dcbbe5f69daa717ea1938d6bf6fab3149cbc50cefbd14e68e3963a',
       i686: '7be642dffe2807fc53b4b3b1dde506251ad42a2d24c94b3271db58c61a607711',
     x86_64: '4fd10398c3b8d444dc540aa574e437401597f442f8e2837f2a2eacabc08d83ba',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
