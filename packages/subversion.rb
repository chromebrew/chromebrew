require 'buildsystems/autotools'

class Subversion < Autotools
  description 'Subversion is an open source version control system.'
  homepage 'https://subversion.apache.org/'
  version '1.15.0'
  license 'Apache-2.0, BSD, MIT, BSD-2, FSFAP and unicode'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dlcdn.apache.org/subversion/subversion-#{version}.tar.bz2"
  source_sha256 'dfb7b1e5270c7def971ccbd5938b0c03b1b5bd60b6674a2d8a74a9560839fb8c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c3d7b1f32c85449cb3aa35d94d39b95a5fd94d59eeb2ce2ccd4d2439819c900',
     armv7l: '2c3d7b1f32c85449cb3aa35d94d39b95a5fd94d59eeb2ce2ccd4d2439819c900',
     x86_64: 'ed282e21b1f55def9f52e324eeb302d9a9afda8ad4f13b4f04d83d44a101b6db'
  })

  depends_on 'apr' => :library
  depends_on 'apr_util' => :library
  depends_on 'bzip2' => :executable
  depends_on 'expat' => :library
  depends_on 'filecmd' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libcyrussasl' => :library
  depends_on 'libxcrypt' => :executable
  depends_on 'lz4' => :library
  depends_on 'lzlib' => :executable
  depends_on 'serf' => :library
  depends_on 'sqlite' => :library
  depends_on 'util_linux' => :executable
  depends_on 'xzutils' => :executable
  depends_on 'zlib' => :library
  depends_on 'zstd' => :executable

  autotools_configure_options '--disable-static --with-utf8proc=internal'

  def self.prebuild
    ConvenienceFunctions.libtoolize('expat')
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
  end
end
