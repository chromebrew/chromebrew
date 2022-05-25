require 'package'

class Fswatch < Package
  description 'fswatch is a file change monitor that receives notifications when the contents of the specified files or directories are modified.'
  homepage 'https://github.com/emcrisostomo/fswatch'
  version '1.17.1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/emcrisostomo/fswatch/releases/download/1.17.1/fswatch-1.17.1.tar.gz'
  source_sha256 'c38e341c567f5f16bfa64b72fc48bba5e93873d8572522e670e6f320bbc2122f'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fswatch/1.17.1_armv7l/fswatch-1.17.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fswatch/1.17.1_armv7l/fswatch-1.17.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fswatch/1.17.1_x86_64/fswatch-1.17.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c7aa03d97680a5eb2b74a62a6f4de45ee1f901625ce133f4226e89e3ca3875f8',
     armv7l: 'c7aa03d97680a5eb2b74a62a6f4de45ee1f901625ce133f4226e89e3ca3875f8',
     x86_64: '3067616e2a4e9d0e6286398392e6f6d97b1b30b355a9f9279bdb96b08a227da9'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
