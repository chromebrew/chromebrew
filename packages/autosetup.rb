require 'package'

class Autosetup < Package
  description 'autosetup is a tool, similar to autoconf, to configure a build system'
  homepage 'https://msteveb.github.io/autosetup/'
  version '0.7.2'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/msteveb/autosetup.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '03842300c4bb4bbe2c670b1e2cc5cc73e744eb9f0284489e1ee39fe3c90787c6',
     armv7l: '03842300c4bb4bbe2c670b1e2cc5cc73e744eb9f0284489e1ee39fe3c90787c6',
       i686: '78d7cd743fb27abf134340aa58614d92690762f06c6c92b165572d4bc91ef4f8',
     x86_64: 'b32c0ea05f8182e639157eb4c7dcfafe1ade90100c92a768eb9309f2d37a2106'
  })

  depends_on 'tcl'

  def self.build
    system 'make'
  end

  def self.install
    system "./autosetup --sysinstall=#{CREW_DEST_PREFIX}"
  end
end
