# Adapted from Arch Linux luit PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/luit/trunk/PKGBUILD

require 'buildsystems/autotools'

class Luit < Autotools
  description 'Filter that can be run between an arbitrary application and a UTF-8 terminal emulator'
  homepage 'https://invisible-island.net/luit/luit.html'
  version '20260907'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ThomasDickey/luit-snapshots.git'
  git_hashtag "t#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41b80f724c181f78d47c9329ba638609f5fedd15ec217de63972e3bbaddc6025',
     armv7l: '41b80f724c181f78d47c9329ba638609f5fedd15ec217de63972e3bbaddc6025',
     x86_64: 'de4fb1073a726c13c5b542f6abbf3a36a008c0aac908a84f903cdeffec38714f'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libfontenc' => :executable
  depends_on 'libx11' => ':build'

  autotools_configure_options '--enable-fontenc'
end
