# Adapted from Arch Linux luit PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/luit/trunk/PKGBUILD

require 'buildsystems/autotools'

class Luit < Autotools
  description 'Filter that can be run between an arbitrary application and a UTF-8 terminal emulator'
  homepage 'https://invisible-island.net/luit/luit.html'
  version '20250912'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ThomasDickey/luit-snapshots.git'
  git_hashtag "t#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5e0646cd5144876dbab261938a5b25a8ef5326290e85c3d998706b0327264869',
     armv7l: '5e0646cd5144876dbab261938a5b25a8ef5326290e85c3d998706b0327264869',
     x86_64: 'bdba06704ca949d6ce72e88655cf48f96dcbee2ae1f28f0b2e28db9d04b757f7'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libfontenc' => :executable
  depends_on 'libx11' => ':build'

  autotools_configure_options '--enable-fontenc'
end
