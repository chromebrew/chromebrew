require 'buildsystems/autotools'

class Libunbound < Autotools
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.26.2'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 'd8ee7aa6bbb3ff1be7d9e57637d0d0ec2f18273a8efff1a0afe2c665858b96f7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3b453ed9f1a008ee2e7a874f5bfb8ee139a9f3229f96ff32e3f007484776471',
     armv7l: 'f3b453ed9f1a008ee2e7a874f5bfb8ee139a9f3229f96ff32e3f007484776471',
       i686: 'ad57ecf2e4c82070fec0349353c70da8c7c62c7d28eed3beb32852f679269231',
     x86_64: '4309d0a8e991d34b5adeb2ac63d858a939fddacf379c45c053d043483766653c'
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
