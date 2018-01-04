require 'package'

class Inxi < Package
  description 'inxi is a full featured CLI system information tool.'
  homepage 'https://smxi.org/docs/inxi.htm'
  version '811a19'
  source_url 'https://github.com/smxi/inxi/archive/811a199badbacc8d54254264c51de8dc3f5c82d2.tar.gz'
  source_sha256 'fd4d7e89166f4cd96fe91448753a1279520bc0f9ee3a2cfbd92ff4a2b1cf487a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gawk'

  def self.install
    system "install -Dm755 inxi #{CREW_DEST_PREFIX}/bin/inxi"
    system "install -Dm644 inxi.1.gz #{CREW_DEST_PREFIX}/man/man1/inxi.1.gz"
  end
end
