require 'package'

class Bitpocket < Package
  description '"DIY Dropbox" or "2-way directory (r)sync with proper deletion"'
  homepage 'https://github.com/sickill/bitpocket'
  version '0.2'
  source_url 'https://github.com/sickill/bitpocket/archive/v0.2.tar.gz'
  source_sha256 'f3952374a1139465700f9122d7a929227be5cdeb681679cbe00bb93658adbd1f'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 bin/bitpocket #{CREW_DEST_PREFIX}/bin/bitpocket"
  end
end
