require 'buildsystems/cmake'

class Quazip < CMake
  description 'Qt/C++ wrapper over minizip'
  homepage 'https://github.com/stachenov/quazip'
  version '1.4'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/stachenov/quazip.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '190d956cdbb724a4676fdf4ac1da6b735d69c2e72b5ef13493c97d208b1a3c8d',
     armv7l: '190d956cdbb724a4676fdf4ac1da6b735d69c2e72b5ef13493c97d208b1a3c8d',
     x86_64: '5ffaade26aecf6861b5b2ef41bc2bb9a80a9c9a8aa2a6299c5bdc891f35f9c20'
  })

  depends_on 'qt5_base'
  depends_on 'zlib'
  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
