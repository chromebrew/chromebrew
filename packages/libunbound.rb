require 'buildsystems/autotools'

class Libunbound < Autotools
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.18.0'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 '3da95490a85cff6420f26fae0b84a49f5112df1bf1b7fc34f8724f02082cb712'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.18.0_armv7l/libunbound-1.18.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.18.0_armv7l/libunbound-1.18.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.18.0_i686/libunbound-1.18.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.18.0_x86_64/libunbound-1.18.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5cf33946c41c35de204735c52bc42191390c35521af836238e23922adc9cef41',
     armv7l: '5cf33946c41c35de204735c52bc42191390c35521af836238e23922adc9cef41',
       i686: 'cac1ed67843a9f7fc4de0b83650da487b29335019b52f44b2be3fefee84b0d92',
     x86_64: 'f3670106f6b6d199612be06ae0c16f3049711bd78ffdbd4b2b3e649165143cfa'
  })

  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R On i686 openssl needs to be installed before libunbound.

  configure_options '--enable-shared \
    --enable-static \
    --with-pic'

  def self.postinstall
    # Use IPv4 if default fails.
    system "#{CREW_PREFIX}/sbin/unbound-anchor -a '#{CREW_PREFIX}/etc/unbound/root.key' || #{CREW_PREFIX}/sbin/unbound-anchor -4 -a '#{CREW_PREFIX}/etc/unbound/root.key'"
  end
end
