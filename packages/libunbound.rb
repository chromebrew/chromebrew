require 'buildsystems/autotools'

class Libunbound < Autotools
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.25.2'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 '0d92275c703d5f5f8baba3dab22117dd8c29b495588a5c229768ed6581566600'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e17aada47876558c2962220fa3088dcd9f7ede33cd9820f1a0ac423839d3f6a5',
     armv7l: 'e17aada47876558c2962220fa3088dcd9f7ede33cd9820f1a0ac423839d3f6a5',
       i686: '364c0e8ad05a2a4173be904f19a5a9cd784c4f50c4589a5e695089b3859dc49e',
     x86_64: '30520cd219e5345e596c32e3e13d0f255c77564bad140f1d4ed1ad611650ceab'
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
