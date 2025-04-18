require 'buildsystems/autotools'

class Dejagnu < Autotools
  description 'DejaGnu is a framework for running test suites on GNU tools.'
  homepage 'https://www.gnu.org/software/dejagnu/'
  version '1.6.3'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/dejagnu/dejagnu-#{version}.tar.gz"
  source_sha256 'bf5b28bb797e0ace4cfc0766a996339c795d8223bef54158be7887046bc01692'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94e52d8bd744a7addadcc5572f5ca4707661abe30f0f3215d0e992041ef96b78',
     armv7l: '94e52d8bd744a7addadcc5572f5ca4707661abe30f0f3215d0e992041ef96b78',
       i686: '7fd6e3d220fba8e4dc7cbfde6fb702362fe8e9fee2ba86bd78c3d9b0709ccbf6',
     x86_64: '0738553253f346fb968c5a210dd4a9d2afef0336c1374af442c794d703b9d0bf'
  })

  depends_on 'expect'
  depends_on 'texinfo'
  run_tests

  configure_build_extras do
    system 'makeinfo --html --no-split -o doc/dejagnu.html doc/dejagnu.texi'
    system 'makeinfo --plaintext       -o doc/dejagnu.txt  doc/dejagnu.texi'
  end

  configure_install_extras do
    system "install -v -dm755   #{CREW_DEST_PREFIX}/share/doc/dejagnu-1.6.1"
    system "install -v -m644 doc/dejagnu.html #{CREW_DEST_PREFIX}/share/doc/dejagnu-1.6.1"
    system "install -v -m644 doc/dejagnu.txt  #{CREW_DEST_PREFIX}/share/doc/dejagnu-1.6.1"
  end
end
