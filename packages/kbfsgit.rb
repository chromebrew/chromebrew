require 'package'

class Kbfsgit < Package
  description 'Keybase encrypted git repositories.'
  homepage 'https://keybase.io/docs/kbfs'
  version '1.0.40'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/keybase/kbfs/archive/v1.0.40.tar.gz'
  source_sha256 '2bbbfd2eb7ed12295375a182656af6dcc509827f7ed83c2b1dd0f72f56853fa5'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kbfsgit/1.0.40_armv7l/kbfsgit-1.0.40-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kbfsgit/1.0.40_armv7l/kbfsgit-1.0.40-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kbfsgit/1.0.40_i686/kbfsgit-1.0.40-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kbfsgit/1.0.40_x86_64/kbfsgit-1.0.40-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '23d60c0673cea6be297723edba12de195c333f3f575c1f6e4860a66b8739c1a4',
     armv7l: '23d60c0673cea6be297723edba12de195c333f3f575c1f6e4860a66b8739c1a4',
       i686: '7714a0c9d259a7001f0b78cdb3848f1a9dc0b032fa8428e0153a278cd9c7d2dd',
     x86_64: 'a6d5354a474c40cac6183e716912ace7cc8144e086ac0e6ea733e07a3c590c4c'
  })

  depends_on 'keybase'

  def self.install
    system 'go get github.com/keybase/kbfs/kbfsgit/git-remote-keybase'
    system "go build -o #{CREW_DEST_PREFIX}/bin/git-remote-keybase -tags production github.com/keybase/kbfs/kbfsgit/git-remote-keybase"
  end
end
