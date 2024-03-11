require 'package'

class Libxt < Package
  description 'X.org X Toolkit Library'
  homepage 'https://www.x.org'
  version '1.2.1'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/archive/individual/lib/libXt-1.2.1.tar.gz'
  source_sha256 '6da1bfa9dd0ed87430a5ce95b129485086394df308998ebe34d98e378e3dfb33'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7ff82ccb3d878142449b1b61b4523a37c02a6341588165541159175d313dabf',
     armv7l: 'a7ff82ccb3d878142449b1b61b4523a37c02a6341588165541159175d313dabf',
     x86_64: 'c59be078d6b5120a57ee6a0ee21caea62e9f6a227855e014a3b661c3400e50f0'
  })

  depends_on 'libsm'
  depends_on 'libx11'
  patchelf

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
