# Adapted from Arch Linux unifdef PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/unifdef/trunk/PKGBUILD

require 'package'

class Unifdef < Package
  description 'Remove #ifdefed lines'
  homepage 'https://dotat.at/prog/unifdef/'
  version '2.12'
  license 'GPL'
  compatibility 'all'
  source_url 'https://dotat.at/prog/unifdef/unifdef-2.12.tar.gz'
  source_sha256 'fba564a24db7b97ebe9329713ac970627b902e5e9e8b14e19e024eb6e278d10b'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/unifdef/2.12_armv7l/unifdef-2.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/unifdef/2.12_armv7l/unifdef-2.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/unifdef/2.12_i686/unifdef-2.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/unifdef/2.12_x86_64/unifdef-2.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '049abcc39d5ee4acaab7e5efb76db652247a561edbc603cb6638e5cc75793372',
     armv7l: '049abcc39d5ee4acaab7e5efb76db652247a561edbc603cb6638e5cc75793372',
       i686: '475d9982f35e444931d3b8a9b7fd30b004889d3738796ad34e3a5016e921ae1e',
     x86_64: '815cb4c067f8deaa14f9dff9efd93b5e6aef2a8dc55c9107efd29b085b71797c'
  })

  depends_on 'glibc' # R

  def self.build
    system 'make clean'
    system 'make'
  end

  def self.install
    FileUtils.install 'unifdef', "#{CREW_DEST_PREFIX}/bin/", mode: 0o755
    FileUtils.install 'unifdefall.sh', "#{CREW_DEST_PREFIX}/bin/unifdefall", mode: 0o755
    FileUtils.install 'unifdef.1', "#{CREW_DEST_MAN_PREFIX}/man1/unifdef.1", mode: 0o644
  end
end
