require 'buildsystems/autotools'

class Libunbound < Autotools
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.26.1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 '35a6dc0e425a9282c3426d9a3043144011bf0534aed4b73ab62c52aee0af1503'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '782d4a5d246f792b0f92b7a04b373af25d3354553d959f75c31707b615a5db10',
     armv7l: '782d4a5d246f792b0f92b7a04b373af25d3354553d959f75c31707b615a5db10',
       i686: '5d8541bec91e5c7dc29b8a3c08e3d3c2c2f6d079981aae5d86059f42d6d57842',
     x86_64: '27a4226ae55cf750b0918551f22afe6f054825aa56da9e31a95a49f24e42d8c1'
  })

  depends_on 'expat' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library

  autotools_configure_options '--enable-shared \
    --enable-static \
    --with-pic'

  def self.postinstall
    # Use IPv4 if default fails.
    system "#{CREW_PREFIX}/sbin/unbound-anchor -a '#{CREW_PREFIX}/etc/unbound/root.key' || #{CREW_PREFIX}/sbin/unbound-anchor -4 -a '#{CREW_PREFIX}/etc/unbound/root.key'"
  end
end
