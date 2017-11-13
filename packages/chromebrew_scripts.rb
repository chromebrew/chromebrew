require 'package'

class Chromebrew_scripts < Package
  description 'Useful bash utility scripts for Chrome/Chromium OS systems.'
  homepage 'https://github.com/uberhacker/chromebrew-scripts'
  version '1.1.0'
  source_url 'https://github.com/uberhacker/chromebrew-scripts/archive/1.1.0.tar.gz'
  source_sha256 'acf8f89ef3b8a04fc33bb5a94188687d0fdd2dd7b05102ad442a91019cab20fb'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 chromebrew #{CREW_DEST_PREFIX}/bin/chromebrew"
    system "install -Dm755 powerwash #{CREW_DEST_PREFIX}/bin/powerwash"
    system "install -Dm755 rootfs #{CREW_DEST_PREFIX}/bin/rootfs"
    system "install -Dm755 rw #{CREW_DEST_PREFIX}/bin/rw"
  end
end
