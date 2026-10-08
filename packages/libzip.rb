require 'buildsystems/cmake'

class Libzip < CMake
  description 'libzip is a C library for reading, creating, and modifying zip archives.'
  homepage 'https://libzip.org/'
  version '1.12'
  license 'BSD'
  compatibility 'all'
  source_url "https://libzip.org/download/libzip-#{version}.tar.xz"
  source_sha256 '376908d0f0fda13180a19fdc4f7062a1abfb59e09ca07a392d361253b8e60c2b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd0212348f6047b3dcf39d3dc86e5d0cf7aaa62ed125f93f196b60a47eac665b',
     armv7l: 'dd0212348f6047b3dcf39d3dc86e5d0cf7aaa62ed125f93f196b60a47eac665b',
       i686: '3b54ff4a5e64cd24a3d8ee57f1c32ec1ed1ef610da03641dd64eb2eea565528f',
     x86_64: '5910ac2f4a4d3e75f16fc092ccf876b8df45745f03487e8bf573d03560d3dc17'
  })

  depends_on 'bzip2' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libmbedtls' => :library
  depends_on 'openssl' => :library
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library
end
