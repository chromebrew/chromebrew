require 'buildsystems/cmake'

class Nuspell < CMake
  description 'Nuspell is a fast and safe spelling checker software program.'
  homepage 'https://nuspell.github.io/'
  version '5.1.7'
  license 'LGPL-3.0, GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/nuspell/nuspell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1783c2cb9635732c5c1199490f9453ecf2263e85c0fa273a057d19a095c34316',
     armv7l: '1783c2cb9635732c5c1199490f9453ecf2263e85c0fa273a057d19a095c34316',
       i686: 'fab4f186e62d5a90da541778c12541d60413328b60f877a460279b51064b26db',
     x86_64: 'ac05081c6ef527225c697e1d1606be8838b8b59bde1ed7c73541d6a9d91b8ce0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'graphviz' => :build
  depends_on 'icu4c' # R
  depends_on 'pandoc' => :build

  run_tests
end
