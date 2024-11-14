require 'buildsystems/autotools'

class Findutils < Autotools
  description 'the basic directory searching utilities of the GNU operating system'
  homepage 'https://www.gnu.org/software/findutils/'
  version '4.10.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/findutils/findutils-4.10.0.tar.xz'
  source_sha256 '1387e0b67ff247d2abde998f90dfbf70c1491391a59ddfecb8ae698789f0a4f5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb232a6606497ed4d567854989842584e814d0342455306d75af520dcf513235',
     armv7l: 'fb232a6606497ed4d567854989842584e814d0342455306d75af520dcf513235',
       i686: '01f38c767f135bea358cceb0cd9ba4c4aef1815c5a6d0baa0db797de403fd18a',
     x86_64: 'f0b7307d68f232450f567e914ef515f67325db7276c3775ad701dd545a28b8b9'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  configure_options "--without-selinux #{'--disable-year2038' unless ARCH.eql?('x86_64')}"
  run_tests
end
