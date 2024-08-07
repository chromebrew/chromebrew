require 'buildsystems/autotools'

class Libsass < Autotools
  description 'LibSass is a C/C++ port of the Sass engine'
  homepage 'https://sass-lang.com/libsass'
  version '3.6.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sass/libsass.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54edb65b75e405ab734f847204f8b1ccfb583064afffb2698db29d4ec5573da1',
     armv7l: '54edb65b75e405ab734f847204f8b1ccfb583064afffb2698db29d4ec5573da1',
    i686: '0782e46f2985d8d7b5e5d3d6da925a86e4a326da305b8b2a6054ff7afd92516f',
  x86_64: 'cd346d8a6208d342781864cfdfaebafccf06a1491c72b385b34d12cccb43d146'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
