require 'buildsystems/autotools'

class Alpine < Autotools
  description 'The continuation of the Alpine email client from University of Washington.'
  homepage 'https://alpineapp.email/'
  version '2.26'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://alpineapp.email/alpine/release/src/alpine-#{version}.tar.xz"
  source_sha256 'c0779c2be6c47d30554854a3e14ef5e36539502b331068851329275898a9baba'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '97f66e93f7de167aa3c97e30e4aa5aceaf7f79f74a9c393d22d3049608a9c811',
     armv7l: '97f66e93f7de167aa3c97e30e4aa5aceaf7f79f74a9c393d22d3049608a9c811',
       i686: '4e27c9aea09ba924079a2859bbbd95f2fbae2222fe1b2467e911fe48e1807cc3',
     x86_64: '04ae487cecf31e36e722c60139ca25d6261271a1fffaae37149e9446b2ad43a1'
  })

  depends_on 'e2fsprogs'
  depends_on 'glibc' # R
  depends_on 'hunspell_en_us'
  depends_on 'krb5' # R
  depends_on 'libcyrussasl' # R
  depends_on 'ncurses' # R
  depends_on 'openldap'
  depends_on 'openssl' # R
  depends_on 'tcl' # R

  autotools_make_j1
  run_tests

  autotools_pre_configure_options <<~OPT
    CFLAGS='#{CREW_COMMON_FLAGS} -Wno-error=incompatible-pointer-types -std=gnu17' \
    CXXFLAGS='#{CREW_COMMON_FLAGS} -Wno-error=incompatible-pointer-types -std=gnu17'
  OPT

  autotools_configure_options <<~OPT
    --with-ssl-dir=#{CREW_PREFIX}/etc/ssl \
    --with-ssl-include-dir=#{CREW_PREFIX}/include \
    --with-ssl-lib-dir=#{CREW_LIB_PREFIX} \
    --disable-nls \
    --with-system-pinerc=#{CREW_PREFIX}/etc/alpine.d/pine.conf \
    --with-system-fixed-pinerc=#{CREW_PREFIX}/etc/alpine/pine.conf.fixed
  OPT

  autotools_install_extras do
    FileUtils.rm_r "#{CREW_DEST_PREFIX}/tmp"
  end
end
