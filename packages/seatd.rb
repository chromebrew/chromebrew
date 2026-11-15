# Adapted from Arch Linux seatd PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/seatd/trunk/PKGBUILD

require 'buildsystems/meson'

class Seatd < Meson
  description 'A minimal seat management daemon, and a universal seat management library'
  homepage 'https://sr.ht/~kennylevinsen/seatd/'
  version '0.9.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://git.sr.ht/~kennylevinsen/seatd/archive/#{version}.tar.gz"
  source_sha256 '302564d54d8e28191fadfd734f2675ecb0c9e0615a58011b89ef15dfa4dbaa96'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2eac2d212aa0077f01d231d6f4db0ea9e2d2706a9fb78a95498913a7274c9f2c',
     armv7l: '2eac2d212aa0077f01d231d6f4db0ea9e2d2706a9fb78a95498913a7274c9f2c',
     x86_64: 'e7b341079c81ba99d7f652b81adfe8ceb8bcaf12931e3ed57280fdfd5f45ae4a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  meson_options '-Dlibseat-logind=disabled \
    -Dlibseat-seatd=enabled \
    -Dlibseat-builtin=enabled \
    -Dexamples=disabled \
    -Dserver=enabled'
end
