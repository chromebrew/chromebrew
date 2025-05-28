require 'buildsystems/autotools'

class Subversion < Autotools
  description 'Subversion is an open source version control system.'
  homepage 'https://subversion.apache.org/'
  version '1.14.5'
  license 'Apache-2.0, BSD, MIT, BSD-2, FSFAP and unicode'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dlcdn.apache.org/subversion/subversion-#{version}.tar.bz2"
  source_sha256 'e78a29e7766b8b7b354497d08f71a55641abc53675ce1875584781aae35644a1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '031f912936482d1e50a3511664fc7ffbc78687a842ed7bc6e265819397e54d12',
     armv7l: '031f912936482d1e50a3511664fc7ffbc78687a842ed7bc6e265819397e54d12',
     x86_64: '2fc3bd85b7c4a08101c7f7e55a0f4b789f87d942ec591d7351de1faa250fc074'
  })

  depends_on 'apr' # R
  depends_on 'apr_util' # R
  depends_on 'bzip2' # R
  depends_on 'expat' # R
  depends_on 'filecmd' # R
  depends_on 'glibc' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libxcrypt' # R
  depends_on 'lz4' # R
  depends_on 'lzlib' # R
  depends_on 'serf' # R
  depends_on 'sqlite' # R
  depends_on 'util_linux' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  autotools_configure_options '--disable-static --with-utf8proc=internal'

  def self.prebuild
    ConvenienceFunctions.libtoolize('expat')
  end
end
