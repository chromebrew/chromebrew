require 'package'

class Ninja < Package
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  version '1.10.0'
  compatibility 'all'
  source_url 'https://github.com/ninja-build/ninja/archive/v1.10.0.tar.gz'
  source_sha256 '3810318b08489435f8efc19c05525e80a993af5a55baa0dfeae0465a9d45f99f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ninja-1.10.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ninja-1.10.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ninja-1.10.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ninja-1.10.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5e2ef70ad213e86a4a32e48bb4783face0bff6f3b079080d3d668bb35ba83088',
     armv7l: '5e2ef70ad213e86a4a32e48bb4783face0bff6f3b079080d3d668bb35ba83088',
       i686: 'ec2996217bdf7c57d0528a8ba0eefabda15c17e59f958daebc3fe1eda6a8a9bc',
     x86_64: 'e74f2b1d374edd0ff0877939b3afb8fa80240774bf3c9126278e5a965c7a5d0b',
  })
  
  depends_on 'python3'

  def self.build
    system 'python3 configure.py --bootstrap'
  end

  def self.install
    system "install -Dm755 ninja #{CREW_DEST_PREFIX}/bin/ninja"
  end
end
