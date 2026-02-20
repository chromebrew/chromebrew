require 'buildsystems/autotools'

class Libunbound < Autotools
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.24.2'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 '44e7b53e008a6dcaec03032769a212b46ab5c23c105284aa05a4f3af78e59cdb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'afab8a9c7459cc9b24d6ea9d33201d415f92f97edb415088e29ac5c930f0bbf6',
     armv7l: 'afab8a9c7459cc9b24d6ea9d33201d415f92f97edb415088e29ac5c930f0bbf6',
       i686: '3800840a12073ba27bdd03aaa13885f1c722c3665a7d132219be179ac68d378e',
     x86_64: 'e6f60b3ea6334804c1ea2e1f16aa195f340aa0e4e2dd92bc46b707fec5825847'
  })

  depends_on 'expat' => :executable_only
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R On i686 openssl needs to be installed before libunbound.

  autotools_configure_options '--enable-shared \
    --enable-static \
    --with-pic'

  def self.postinstall
    # Use IPv4 if default fails.
    system "#{CREW_PREFIX}/sbin/unbound-anchor -a '#{CREW_PREFIX}/etc/unbound/root.key' || #{CREW_PREFIX}/sbin/unbound-anchor -4 -a '#{CREW_PREFIX}/etc/unbound/root.key'"
  end
end
