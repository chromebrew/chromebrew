require 'buildsystems/autotools'

class Goaccess < Autotools
  description 'GoAccess is an open source real-time web log analyzer and interactive viewer that runs in a terminal in *nix systems or through your browser.'
  homepage 'https://goaccess.io/'
  version '1.12'
  license 'MIT'
  compatibility 'all'
  source_url "https://tar.goaccess.io/goaccess-#{version}.tar.gz"
  source_sha256 '3aef5f6d5061decc6fc4946339b3a61b170bd256f80b4e861194b095df83ec86'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e9be6d913d322f13fc15325acafa0b622ee9724db3c534f94f5ebee248f3efa',
     armv7l: '4e9be6d913d322f13fc15325acafa0b622ee9724db3c534f94f5ebee248f3efa',
       i686: '57143e3f7539d01c727ac7bba4e9656c5de15cca2526ac445e003ac87e631789',
     x86_64: '4c0cfe235306c41da9ecad3d30f754747df85eddcf5b58ebefa7b7908c54183a'
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
