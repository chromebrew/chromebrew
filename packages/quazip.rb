require 'buildsystems/cmake'

class Quazip < CMake
  description 'Qt/C++ wrapper over minizip'
  homepage 'https://github.com/stachenov/quazip'
  version '1.7.2'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/stachenov/quazip.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8abe4188c4987ea8c0d66c6deb28d97981b87ea9187a2f5dad0d6cdddca0563',
     armv7l: 'a8abe4188c4987ea8c0d66c6deb28d97981b87ea9187a2f5dad0d6cdddca0563',
     x86_64: '4e351c70376602fb70686a902f4156fdf0b0ffbd8567c449f04bb1cd99e14216'
  })

  depends_on 'bzip2' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'qt5_base' => :library
  depends_on 'zlib' => :library
end
