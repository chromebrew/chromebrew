require 'package'

class Ninja < Package
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  version '1.9.0'
  source_url 'https://github.com/ninja-build/ninja/archive/v1.9.0.tar.gz'
  source_sha256 '5d7ec75828f8d3fd1a0c2f31b5b0cea780cdfe1031359228c428c1a48bfcd5b9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ninja-1.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ninja-1.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ninja-1.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ninja-1.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b9f89afdefe5747802c7ccd5184775c2a18f8f66f380cf68213c3c86833f0822',
     armv7l: 'b9f89afdefe5747802c7ccd5184775c2a18f8f66f380cf68213c3c86833f0822',
       i686: 'c1a6a31fec8fd4185ab6c7e478f7cc935c3f836c7e399f2a74725946e9d23d98',
     x86_64: 'a1b8db9d11211ece355c2d4d7a1fecffb719d0d47b1c5c48276a2cb22f505f62',
  })

  depends_on 'python3'
  depends_on 're2c'
  depends_on 'unzip'

  def self.build
    system "python3 configure.py --bootstrap"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp ninja #{CREW_DEST_PREFIX}/bin/"
  end
end
