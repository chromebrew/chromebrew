require 'buildsystems/cmake'

class Pugixml < CMake
  description 'Light-weight, simple and fast XML parser for C++ with XPath support'
  homepage 'https://pugixml.org/'
  version '1.16'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/zeux/pugixml.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d809066d2e8a40f52eacf7bf2d51d62dab2fd347606467537e67647ea732366',
     armv7l: '3d809066d2e8a40f52eacf7bf2d51d62dab2fd347606467537e67647ea732366',
       i686: '903788081ca878df36f23630755485733965cc3f663106576d13a79bd3f4872f',
     x86_64: '3e405d77799cd276db4374b92d44560e8cfcf82491d37a96d69fa10b6bc939f5'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
