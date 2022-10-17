require 'package'

class Libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  @_ver = '1.15.0'
  version @_ver
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{@_ver}.tar.gz"
  source_sha256 'a480dc6c8937447b98d161fe911ffc76cfaffa2da18788781314e81339f1126f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.15.0_armv7l/libunbound-1.15.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.15.0_armv7l/libunbound-1.15.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.15.0_i686/libunbound-1.15.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.15.0_x86_64/libunbound-1.15.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '138691148c63f343b99d70e58405f26a5efc185cefb0aa6e7f9d96a8e5738131',
     armv7l: '138691148c63f343b99d70e58405f26a5efc185cefb0aa6e7f9d96a8e5738131',
       i686: '1eb7e176be91f7fa902a75295a81d1116745b3fd71ef87588964b7c2e129c363',
     x86_64: '5c4125bce66bb83fc775a5fe236718dee958b9724d5b6adf55d3b682c2b05401'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R On i686 openssl needs to be installed before libunbound.

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure \
    #{CREW_OPTIONS} \
    #{CREW_ENV_OPTIONS} \
    --enable-shared \
    --enable-static \
    --with-pic"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end

  def self.check
    system 'make', 'test'
  end

  def self.postinstall
    # Use IPv4 if default fails.
    system "#{CREW_PREFIX}/sbin/unbound-anchor -a '#{CREW_PREFIX}/etc/unbound/root.key' || #{CREW_PREFIX}/sbin/unbound-anchor -4 -a '#{CREW_PREFIX}/etc/unbound/root.key'"
  end
end
