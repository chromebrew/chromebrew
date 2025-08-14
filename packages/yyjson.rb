# Adapted from Arch Linux yyjson PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yyjson

require 'buildsystems/cmake'

class Yyjson < CMake
  description 'A high performance JSON library written in ANSI C'
  homepage 'https://ibireme.github.io/yyjson'
  version '0.11.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ibireme/yyjson.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c5b6b4c4e70177af3d30de8e6bde00d9695ca7f02eb06e42ca5ff07ef14f678',
     armv7l: '5c5b6b4c4e70177af3d30de8e6bde00d9695ca7f02eb06e42ca5ff07ef14f678',
       i686: '907d2cdf87a79073011b4649b3df7f18a312f304ae5997590d8bfe9a8fefcb29',
     x86_64: '27554b9952ece260c7b760c260e2d76a5cf7a63a0811d173fcc908dd2d0b8d36'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
