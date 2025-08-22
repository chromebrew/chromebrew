require 'buildsystems/autotools'

class Libmicrohttpd < Autotools
  description 'GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application.'
  homepage 'https://www.gnu.org/software/libmicrohttpd/'
  version '1.0.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libmicrohttpd/libmicrohttpd-#{version}.tar.gz"
  source_sha256 'df324fcd0834175dab07483133902d9774a605bfa298025f69883288fd20a8c7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c036bb67a617000cc413608bac37d42415633645dd6913fe1b8d14e24682fa2e',
     armv7l: 'c036bb67a617000cc413608bac37d42415633645dd6913fe1b8d14e24682fa2e',
       i686: 'a248302199a79d99bf6f0b1f97bc0dcd683b29dd0f3e0582aefc961e1434e891',
     x86_64: 'f341a7c5081d6ac9a31220214965bcddacad22fbcaeb2fd89dc618da94cbdaac'
  })

  depends_on 'diffutils' => :build
  depends_on 'glibc' # R
  depends_on 'gnutls' # R

  autotools_configure_options '--disable-examples'
end
