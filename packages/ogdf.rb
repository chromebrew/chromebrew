require 'buildsystems/cmake'

class Ogdf < CMake
  description 'OGDF, the Open Graph Drawing Framework/Open Graph algorithms and Data structure Framework.'
  homepage 'http://www.ogdf.net/'
  version '2025.10'
  license 'GPL-2.0, GPL-3.0, Unknown'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ogdf/ogdf.git'
  git_hashtag "foxglove-#{version.sub('.', '')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '314774e22aa481e2d89f9c406b4c21cc390cfa0174757470704c609e7bc732a3',
     armv7l: '314774e22aa481e2d89f9c406b4c21cc390cfa0174757470704c609e7bc732a3',
     x86_64: 'd1802c25b72bceac07233151b8b553e649b6ec577a4f6d71bcf1a526da4f3c00'
  })

  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'graphviz' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
