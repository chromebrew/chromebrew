require 'buildsystems/autotools'

class Xorg_evdev_driver < Autotools
  description 'Generic Linux input driver for the Xorg X server.'
  homepage 'https://gitlab.freedesktop.org/xorg/driver/xf86-input-evdev'
  version '2.10.6'
  compatibility 'aarch64 armv7l x86_64'
  license 'MIT'
  source_url 'https://gitlab.freedesktop.org/xorg/driver/xf86-input-evdev.git'
  git_hashtag "xf86-input-evdev-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd15fae840bdb86e14177bc9f7ec5c0ed47326af3b2888c75f4087a28368bdb22',
     armv7l: 'd15fae840bdb86e14177bc9f7ec5c0ed47326af3b2888c75f4087a28368bdb22',
     x86_64: '3ed674dc7de7cc72ceb06df044132d1c7b4f7e5ab033e31d54de4ec5ec4ce7f0'
  })

  depends_on 'mtdev'
  depends_on 'libevdev'
  depends_on 'xorg_server' => :build
end
