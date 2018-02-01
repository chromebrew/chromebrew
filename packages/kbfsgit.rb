require 'package'

class Kbfsgit < Package
  description 'Keybase encrypted git repositories.'
  homepage 'https://keybase.io/docs/kbfs'
  version '1.0.40'
  source_url 'https://github.com/keybase/kbfs/archive/v1.0.40.tar.gz'
  source_sha256 '2bbbfd2eb7ed12295375a182656af6dcc509827f7ed83c2b1dd0f72f56853fa5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'keybase'

  def self.install
    system "go get github.com/keybase/kbfs/kbfsgit"
    system "go build -o #{CREW_DEST_PREFIX}/bin/git-remote-keybase -tags production github.com/keybase/kbfs/kbfsgit"
  end
end
