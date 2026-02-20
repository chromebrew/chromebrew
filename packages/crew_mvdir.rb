require 'package'

class Crew_mvdir < Package
  description 'Faster alternative to "rsync --remove-source-files dir1/ dir2/"'
  homepage 'https://github.com/chromebrew/crew-mvdir'
  version '0.4'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-mvdir.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d834bf53036d27b03a28bcae2db6fff9b53b651adb38fc87130fffd6bda80c8',
     armv7l: '3d834bf53036d27b03a28bcae2db6fff9b53b651adb38fc87130fffd6bda80c8',
       i686: '30a0a65e9b1cb2a662c1687b4cf67b49438ecd241275923a810915144deb9404',
     x86_64: 'd55466dacf8df9994b8ed0b33347f4cd730b4a23d34462672c00b5269e22c2e9'
  })

  depends_on 'glibc' => :executable_only

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
