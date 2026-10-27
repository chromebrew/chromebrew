require 'buildsystems/autotools'

class Xorg_evdev_driver < Autotools
  description 'Generic Linux input driver for the Xorg X server.'
  homepage 'https://gitlab.freedesktop.org/xorg/driver/xf86-input-evdev'
  version '2.11.0'
  compatibility 'aarch64 armv7l x86_64'
  license 'MIT'
  source_url 'https://gitlab.freedesktop.org/xorg/driver/xf86-input-evdev.git'
  git_hashtag "xf86-input-evdev-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '150f1329fa007693fa6d8822c2fd8c8d22b68e8370054f7d6101782d0bf9c0b9',
     armv7l: '150f1329fa007693fa6d8822c2fd8c8d22b68e8370054f7d6101782d0bf9c0b9',
     x86_64: '079f384973e7287bd1bda655f431895264bd360cc8f847ef352619cca9feb9f0'
  })

  depends_on 'eudev' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libevdev' => :library
  depends_on 'mtdev' => :library
  depends_on 'xorg_server' => :build
end
