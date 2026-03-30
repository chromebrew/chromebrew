require 'buildsystems/cmake'

class Quazip < CMake
  description 'Qt/C++ wrapper over minizip'
  homepage 'https://github.com/stachenov/quazip'
  version '1.5'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/stachenov/quazip.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b5a589c02879afff01ae882d56aad6e17ea7a58167fb61424f0e331acb3dec1',
     armv7l: '0b5a589c02879afff01ae882d56aad6e17ea7a58167fb61424f0e331acb3dec1',
     x86_64: 'bd1bd5e605ba863e369819c32faf862f56e11bb3c5372443594a1127fd325c12'
  })

  depends_on 'bzip2' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'qt5_base' => :library
  depends_on 'zlib' => :library
end
