require 'package'

class Chromebrew_scripts < Package
  description 'Useful bash utility scripts for Chrome/Chromium OS systems.'
  homepage 'https://github.com/uberhacker/chromebrew-scripts'
  version '1.0.0'
  source_url 'https://github.com/uberhacker/chromebrew-scripts/archive/1.0.0.tar.gz'
  source_sha256 '97afac04020e9d82e7026113f8040ad609fb4887da202ded129bd7f65b996341'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 powerwash #{CREW_DEST_PREFIX}/bin/powerwash"
    system "install -Dm755 rootfs #{CREW_DEST_PREFIX}/bin/rootfs"
    system "install -Dm755 rw #{CREW_DEST_PREFIX}/bin/rw"
    system "install -Dm755 uninstall #{CREW_DEST_PREFIX}/bin/uninstall"
  end
end
