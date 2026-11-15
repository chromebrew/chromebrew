require 'buildsystems/autotools'

class Passt < Autotools
  description 'Plug A Simple Socket Transport'
  homepage 'https://passt.top/passt/about/'
  version '2026_10_02.cba3570'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://passt.top/passt'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a36bbe28ed559275bd2d7508730b4f730cb4ea0d3ad2e9b43c69717bb50e7ca',
     armv7l: '9a36bbe28ed559275bd2d7508730b4f730cb4ea0d3ad2e9b43c69717bb50e7ca',
     x86_64: 'f015b49eea0ee17c0aa0aba79e40cca4f9b1c494afe9489545bd90cd194038de'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_skip_configure
end
