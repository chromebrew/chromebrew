# Adapted from Arch Linux exempi PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/exempi/trunk/PKGBUILD

require 'buildsystems/autotools'

class Exempi < Autotools
  description 'A library to parse XMP metadata'
  homepage 'https://libopenraw.freedesktop.org/wiki/Exempi'
  version '2.6.6'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://gitlab.freedesktop.org/libopenraw/exempi/-/archive/#{version}/exempi-#{version}.tar.bz2"
  source_sha256 'c553fe596d4e5b44ce645a3d9a8b1d8609f2572d50953b10fe7103380462e084'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '34e33ad229aaa70bb70644700d147b71c604f21a0672f7747088d3eb3aca5214',
     armv7l: '34e33ad229aaa70bb70644700d147b71c604f21a0672f7747088d3eb3aca5214',
     x86_64: 'edd15699260158174906ff7e792d3c2dd68a00082eb0ca15a0945bc4f059420b'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'boost' => :build
  depends_on 'expat' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'zlib' => :library
end
