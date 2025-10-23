require 'buildsystems/autotools'

class Libunbound < Autotools
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.24.1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 '7f2b1633e239409619ae0527f67878b0f33ae0ec0ee5a3a51c042c359ba1eeab'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a347168c876bbc19b5ea622fa6bcdfc8d97c6b5af791c3222c01934dc1a10e65',
     armv7l: 'a347168c876bbc19b5ea622fa6bcdfc8d97c6b5af791c3222c01934dc1a10e65',
       i686: '2fafccf881353b5d8bea70845cffbf8fcd8f503aac7c1e152eacc5b55b199f08',
     x86_64: 'f436148a003daf3200342401f24a9e0e6a80b8bebe3377260324bee56ab76517'
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
