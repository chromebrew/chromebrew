require 'package'

class Keybase < Package
  description 'Keybase is encryption for everyone. Installs keybase cli'
  homepage 'https://keybase.io'
  version '5.5.1'
  compatibility 'all'
  source_url 'https://github.com/keybase/client/archive/v5.5.1.tar.gz'
  source_sha256 'a65dc4b62fc1299dd17da52ddd2484fa1dc1s7d2a4776c3a6e112ee020980b12'

  binary_url ({
    
  })
  binary_sha256 ({
    
  })

  depends_on 'go'

  def self.install
    system "go get github.com/keybase/client/go/keybase"
    system "go build -o #{CREW_DEST_PREFIX}/bin/keybase -tags production github.com/keybase/client/go/keybase"
  end
end
