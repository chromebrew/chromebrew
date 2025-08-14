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
    aarch64: '0f3b86592d168b51d5cde627d3d17976e7c25232acc9be6e88d69140209aecb3',
     armv7l: '0f3b86592d168b51d5cde627d3d17976e7c25232acc9be6e88d69140209aecb3',
       i686: '362dc5aee6821d45a2fb0f6fb3f9d4507fc2dc6bf06ac30b5471c46d6741b015',
     x86_64: '4f94eff48e677f090741730abe971d30b0d18cac2c3816099e2f3ade76aedb0f'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
