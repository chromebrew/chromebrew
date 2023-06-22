require 'package'

class Libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.17.1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 'ee4085cecce12584e600f3d814a28fa822dfaacec1f94c84bfd67f8a5571a5f4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.17.1_armv7l/libunbound-1.17.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.17.1_armv7l/libunbound-1.17.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.17.1_i686/libunbound-1.17.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.17.1_x86_64/libunbound-1.17.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '221a8882a2903fb0783c4708113c2f630a8a1fc61de2427e664823421172b43e',
     armv7l: '221a8882a2903fb0783c4708113c2f630a8a1fc61de2427e664823421172b43e',
       i686: 'e4f090cdb6f1df7cc0df9750a6e6cf5f05a113dd7889cdfd015e7c4480d7fae4',
     x86_64: '7d7ffb5749599f0a772e6b3304a398f1b8a7b17d7ec30858d98da5057522739d'
  })

  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R On i686 openssl needs to be installed before libunbound.

  def self.patch
    system 'filefix'
  end

  def self.build
    system "mold -run ./configure \
    #{CREW_OPTIONS} \
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
