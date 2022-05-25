# Adapted from Arch Linux setconf PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/setconf/trunk/PKGBUILD

require 'package'

class Setconf < Package
  description 'Utility for easily changing settings in configuration files'
  homepage 'https://setconf.roboticoverlords.org/'
  version '0.7.7'
  compatibility 'all'
  license 'GPL2'
  source_url "https://setconf.roboticoverlords.org/setconf-#{version}.tar.xz"
  source_sha256 '19315574540b3181fec31a4059b9e058381e0192317f153d181e7e7e2aa84d86'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/setconf/0.7.7_armv7l/setconf-0.7.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/setconf/0.7.7_armv7l/setconf-0.7.7-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/setconf/0.7.7_i686/setconf-0.7.7-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/setconf/0.7.7_x86_64/setconf-0.7.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd8106e68200d60bd648b24cf982e38e4a02b4ef06fc4f59b861925f1259e4788',
     armv7l: 'd8106e68200d60bd648b24cf982e38e4a02b4ef06fc4f59b861925f1259e4788',
       i686: 'ae85bdab10a698f6bfed275dc4b6cb560efcfc83d96ceb91035fc27a96e4911e',
     x86_64: '152a3f9c7d5a4a7a505913cef5dec91820427faf5a50096c4f42fc36b27e1398'
  })

  depends_on 'python3'

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_MAN_PREFIX}/man1]
    FileUtils.install 'setconf.py', "#{CREW_DEST_PREFIX}/bin/setconf", mode: 0o755
    FileUtils.install 'setconf.1.gz', "#{CREW_DEST_MAN_PREFIX}/man1/setconf.1.gz", mode: 0o644
  end
end
