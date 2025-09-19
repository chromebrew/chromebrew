require 'buildsystems/autotools'

class Libunbound < Autotools
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.24.0'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 '147b22983cc7008aa21007e251b3845bfcf899ffd2d3b269253ebf2e27465086'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1754d7491af817712d8915d3694552458acf55b02c9949447933cb79de8c169c',
     armv7l: '1754d7491af817712d8915d3694552458acf55b02c9949447933cb79de8c169c',
       i686: 'f396e2c55cd22f6be1516a26a51a87331eb3660b8ea9cb7f5651f72ce6efe61d',
     x86_64: 'e2ffec31ffdd64ad089be07dc781ea5e6a0d25203809c64f92a936469e26eb25'
  })

  depends_on 'expat' # R
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
