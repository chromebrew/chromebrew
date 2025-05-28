require 'buildsystems/autotools'

class Libunbound < Autotools
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.22.0'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 'c5dd1bdef5d5685b2cedb749158dd152c52d44f65529a34ac15cd88d4b1b3d43'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64e32be9f9014acf6dbd9ca1639ba5d9b59555d8182b7fbc11b9122feef91579',
     armv7l: '64e32be9f9014acf6dbd9ca1639ba5d9b59555d8182b7fbc11b9122feef91579',
       i686: 'd32fb93dc73cf58782dc155a39bf656295795a761ae48da3c5f48b88fe07bf3e',
     x86_64: '2ad9eb65fc9c304c1b9239af056ec4e6b2ee2a1e6268b6b8e99d5330886aa2d5'
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
