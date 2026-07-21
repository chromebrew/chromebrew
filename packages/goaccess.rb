require 'buildsystems/autotools'

class Goaccess < Autotools
  description 'GoAccess is an open source real-time web log analyzer and interactive viewer that runs in a terminal in *nix systems or through your browser.'
  homepage 'https://goaccess.io/'
  version '1.11'
  license 'MIT'
  compatibility 'all'
  source_url "https://tar.goaccess.io/goaccess-#{version}.tar.gz"
  source_sha256 '01024b129c974582bfe7a4653eb55b1c83cb2b57ab3dda96e820bc185a25ff71'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94d90146a9150cf8cfa0035a850745db5bf1f1f39af70dd57769206775ecb747',
     armv7l: '94d90146a9150cf8cfa0035a850745db5bf1f1f39af70dd57769206775ecb747',
       i686: '450e986e7e9f2550046696557488011a3e9a9a6fb6978b039e7c00a65334d355',
     x86_64: '03aa906f945eff2bbfa8dafacd356daef109310f0ee05e2d2a7e09e9999d7cdf'
  })

  depends_on 'geoip' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'openssl' => :executable

  autotools_pre_configure_options "CFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"

  autotools_configure_options ' \
    --enable-geoip=legacy \
    --enable-utf8 \
    --with-getline \
    --with-openssl'

  run_tests
end
