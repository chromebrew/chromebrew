require 'package'

class Libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  @_ver = '1.13.1'
  version @_ver
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{@_ver}.tar.gz"
  source_sha256 '8504d97b8fc5bd897345c95d116e0ee0ddf8c8ff99590ab2b4bd13278c9f50b8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.13.1_armv7l/libunbound-1.13.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.13.1_armv7l/libunbound-1.13.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.13.1_i686/libunbound-1.13.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libunbound/1.13.1_x86_64/libunbound-1.13.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1e6999af00f48993d63ff36bff111796a1a79894808499ff0afafcf12a6e5c32',
     armv7l: '1e6999af00f48993d63ff36bff111796a1a79894808499ff0afafcf12a6e5c32',
       i686: 'eb5e0d99f4a98ed55e6842d01782e3326045c7a9e3e99e4a3867113d2113a30f',
     x86_64: 'fe16753a6cb9a8c69cf759201f39dec701d29b9de75954c77a2225e32e7a3edc'
  })

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
