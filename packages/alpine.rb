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
    aarch64: '6c919cb0d6fad903fc0e0cb96f1d8bff6030181a9e871b38ccd59a121f342dfe',
     armv7l: '6c919cb0d6fad903fc0e0cb96f1d8bff6030181a9e871b38ccd59a121f342dfe',
       i686: '453a722ceefb5749a215e76599133686011b51c9b45a4747d5c95faf7f94f799',
     x86_64: '31d6176774aee2a53e8fd784816c7daaa361cf80c8ea8fa11f99c3fe22c3bfef'
  })

  depends_on 'e2fsprogs'
  depends_on 'hunspell_en_us'
  depends_on 'openldap'
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
