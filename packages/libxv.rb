require 'package'

class Libxv < Package
  description 'X.org X Window System video extension library'
  homepage 'http://www.x.org'
  version '1.0.11-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXv-1.0.11.tar.gz'
  source_sha256 'c4112532889b210e21cf05f46f0f2f8354ff7e1b58061e12d7a76c95c0d47bb1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxv-1.0.11-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxv-1.0.11-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxv-1.0.11-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxv-1.0.11-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '23314bc66eeaa5e85199bebc283053bcb0de85d9361b4f2a98fa673982f11295',
     armv7l: '23314bc66eeaa5e85199bebc283053bcb0de85d9361b4f2a98fa673982f11295',
       i686: '09c4a2428a623c2c81c5093fd893709f2cf11bab451314ca625729163d60d17d',
     x86_64: '8f3ee446b50d160561283024caff13c7103074e366b65351f69b16c59e41b95d',
  })

  depends_on 'libxext'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
