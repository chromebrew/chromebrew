require 'buildsystems/autotools'

class Links < Autotools
  description 'Links is a lynx-like text WWW browser with tables and frames.'
  homepage 'http://links.twibright.com/'
  version '2.30'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://links.twibright.com/download/links-#{version}.tar.bz2"
  source_sha256 'c4631c6b5a11527cdc3cb7872fc23b7f2b25c2b021d596be410dadb40315f166'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7356e73ee8bf693ae549f23cf6062c4a2ae226eb4a5ac1fdd5ed472cb340452c',
     armv7l: '7356e73ee8bf693ae549f23cf6062c4a2ae226eb4a5ac1fdd5ed472cb340452c',
       i686: '565c3a9c6646904b37a50e5b834b3b666d225be3e8924e0f0dd08afcdbf489e6',
     x86_64: 'b908c2dad31b45cff19e0fd030188ee0afa96f1734d5d745fd8de7f0f8ad871a'
  })

  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'lzlib' # R
  depends_on 'lzma' # R
  depends_on 'openssl'
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  run_tests
end
