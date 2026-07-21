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
    aarch64: '86ddb7db43b3eac8fe522cc0bb71a65274f7fbcf74d94c3d6ee9cc4634247608',
     armv7l: '86ddb7db43b3eac8fe522cc0bb71a65274f7fbcf74d94c3d6ee9cc4634247608',
       i686: 'a94fccfda8b6c1b2959e9d85e2d166c0b6c28789eff943cd8900e6958ee90590',
     x86_64: '2ef9c61fd5a13e7a0d761ac03db327a19f5a81fef88e55d8d572a2498d8413be'
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
