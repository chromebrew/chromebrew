require 'package'

class Keybase < Package
  description 'Keybase is encryption for everyone. Installs keybase cli'
  homepage 'https://keybase.io'
  version '1.0.40'
  source_url 'https://github.com/keybase/client/archive/v1.0.40.tar.gz'
  source_sha256 '79f11737b3bdc279b34d2b978584b3c12e1c24ccdeb3b86dbf7670aa9c634913'

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
