require 'buildsystems/cmake'

class Nuspell < CMake
  description 'Nuspell is a fast and safe spelling checker software program.'
  homepage 'https://nuspell.github.io/'
  version '5.1.9'
  license 'LGPL-3.0, GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/nuspell/nuspell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3fdad695913d25593886c5f979c48c2388604fa61b4f1d8f63208e806b4cd104',
     armv7l: '3fdad695913d25593886c5f979c48c2388604fa61b4f1d8f63208e806b4cd104',
       i686: '90fa69739de479f579c312f30d056cb78bf8e1a4f96ed3116eef249e0acbb63d',
     x86_64: 'af672979cc77259d7f5146d1f3c96b5440e5de49d90582f3acac761998db6605'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :build
  depends_on 'icu4c' => :library

  run_tests

  # man page builds require pandoc, which is not available on armv7l.'
  cmake_options '-DBUILD_MAN=OFF'
end
