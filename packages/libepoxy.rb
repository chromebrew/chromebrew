require 'package'

class Libepoxy < Package
  description 'Epoxy is a library for handling OpenGL function pointer management for you'
  homepage 'https://github.com/anholt/libepoxy'
  version '1.4.3'
  compatibility 'all'
  source_url 'https://github.com/anholt/libepoxy/releases/download/1.4.3/libepoxy-1.4.3.tar.xz'
  source_sha256 '0b808a06c9685a62fca34b680abb8bc7fb2fda074478e329b063c1f872b826f6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libepoxy-1.4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libepoxy-1.4.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libepoxy-1.4.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libepoxy-1.4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9dd06c1be0b7fc47524a9555c0f2c833d44ad906b559b96106f2d97a5dcb7b5a',
     armv7l: '9dd06c1be0b7fc47524a9555c0f2c833d44ad906b559b96106f2d97a5dcb7b5a',
       i686: '606ef69eefad0a980349b5ec283798d631bf4132a9c5b51f0fd939d4aca31df8',
     x86_64: '24975e424f08d7f7afceafcfb76e75ebd4d864b101cea5de7a28d9c1edef6a40',
  })

  depends_on 'mesa'
  depends_on 'python3'

  def self.build
    system "mkdir _build"
    Dir.chdir "_build" do
      system "../configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
      system "make"
    end
  end

  def self.install
    Dir.chdir "_build" do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
