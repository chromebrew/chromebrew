# Adapted from Arch Linux distrobox PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=distrobox

require 'package'

class Distrobox < Package
  description 'Use any linux distribution inside your terminal.'
  homepage 'https://github.com/89luca89/distrobox'
  version '1.4.2.1'
  license 'GPL3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/89luca89/distrobox.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/distrobox/1.4.2.1_armv7l/distrobox-1.4.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/distrobox/1.4.2.1_armv7l/distrobox-1.4.2.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/distrobox/1.4.2.1_x86_64/distrobox-1.4.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '439b4355086a1dc5f1628e0f62c74aea3ab64eff6394f40a18ea23ee53328949',
     armv7l: '439b4355086a1dc5f1628e0f62c74aea3ab64eff6394f40a18ea23ee53328949',
     x86_64: 'f9db02ef1b5ab56c45fe7f0916137c86d730e72a9ff2fd4af17b3ad1ef08da63'
  })

  depends_on 'conmon' # L
  depends_on 'podman'

  def self.install
    system "./install -P #{CREW_DEST_PREFIX}"
  end
end
