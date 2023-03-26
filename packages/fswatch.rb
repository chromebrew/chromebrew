require 'package'

class Fswatch < Package
  description 'fswatch is a file change monitor that receives notifications when the contents of the specified files or directories are modified.'
  homepage 'https://github.com/emcrisostomo/fswatch'
  version '1.17.1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/emcrisostomo/fswatch/releases/download/1.17.1/fswatch-1.17.1.tar.gz'
  source_sha256 'c38e341c567f5f16bfa64b72fc48bba5e93873d8572522e670e6f320bbc2122f'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
