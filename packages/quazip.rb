require 'buildsystems/cmake'

class Quazip < CMake
  description 'Qt/C++ wrapper over minizip'
  homepage 'https://github.com/stachenov/quazip'
  version '1.7.1'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/stachenov/quazip.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55b917c44312435424726014acd487db2ca21c9fcb488a32cd472ce5a2b91d45',
     armv7l: '55b917c44312435424726014acd487db2ca21c9fcb488a32cd472ce5a2b91d45',
     x86_64: 'f35a31e70743d8bede1933a887dcc773d28e7b8b2a7bacd49ab18881bbb68f7d'
  })

  depends_on 'bzip2' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'qt5_base' => :library
  depends_on 'zlib' => :library
end
