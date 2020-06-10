require 'package'

class Chromebrew_scripts < Package
  description 'Useful bash utility scripts for Chrome/Chromium OS systems.'
  homepage 'https://github.com/uberhacker/chromebrew-scripts'
  version '1.1.0'
  compatibility 'all'
  source_url 'https://github.com/uberhacker/chromebrew-scripts/archive/1.1.0.tar.gz'
  source_sha256 'acf8f89ef3b8a04fc33bb5a94188687d0fdd2dd7b05102ad442a91019cab20fb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/chromebrew_scripts-1.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/chromebrew_scripts-1.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/chromebrew_scripts-1.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/chromebrew_scripts-1.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '447d9faf3c89ce8f1b660948c147ce8d176e7a603c8d0c1e5d6fa141c7d42a8e',
     armv7l: '447d9faf3c89ce8f1b660948c147ce8d176e7a603c8d0c1e5d6fa141c7d42a8e',
       i686: 'd7dc131e574831c2a20bd4ef464e70edb213ce26d7da0ac00c5983366c95a7ea',
     x86_64: 'a0131789ac972ebe470bf4a8d7768b6cd0b1044b9a32838b9341a40a40618527',
  })

  def self.install
    system "install -Dm755 chromebrew #{CREW_DEST_PREFIX}/bin/chromebrew"
    system "install -Dm755 powerwash #{CREW_DEST_PREFIX}/bin/powerwash"
    system "install -Dm755 rootfs #{CREW_DEST_PREFIX}/bin/rootfs"
    system "install -Dm755 rw #{CREW_DEST_PREFIX}/bin/rw"
  end
end
