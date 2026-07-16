require 'buildsystems/cmake'

class Nuspell < CMake
  description 'Nuspell is a fast and safe spelling checker software program.'
  homepage 'https://nuspell.github.io/'
  version '5.1.8'
  license 'LGPL-3.0, GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/nuspell/nuspell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cec02424a4b00af322efd6ac475d7ca13d8d5320b85d779b24999de387a3ef87',
     armv7l: 'cec02424a4b00af322efd6ac475d7ca13d8d5320b85d779b24999de387a3ef87',
       i686: '3999030deeb687997fcd43882a3a5131abd575914974fd72d8a7e81a6dc8b0f6',
     x86_64: 'aea3d78e7a039b2faebf1287dde4e7028f1c813accd08f2490527b0a8976c75e'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :build
  depends_on 'icu4c' => :library
  depends_on 'pandoc' => :build

  run_tests
end
