# Adapted from Arch Linux libindicator PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libindicator/trunk/PKGBUILD

require 'package'

class Libindicator_gtk3 < Package
  description 'Set of symbols and convenience functions for Ayatana indicators'
  homepage 'https://launchpad.net/libindicator'
  version '12.10.1'
  license 'GPL3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://launchpad.net/libindicator/12.10/12.10.1/+download/libindicator-12.10.1.tar.gz'
  source_sha256 'b2d2e44c10313d5c9cd60db455d520f80b36dc39562df079a3f29495e8f9447f'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libindicator_gtk3/12.10.1_armv7l/libindicator_gtk3-12.10.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libindicator_gtk3/12.10.1_armv7l/libindicator_gtk3-12.10.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libindicator_gtk3/12.10.1_x86_64/libindicator_gtk3-12.10.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fcfdbe22d476d4fdef9e740149026e867e049f2c9770c7e332206653d002752d',
     armv7l: 'fcfdbe22d476d4fdef9e740149026e867e049f2c9770c7e332206653d002752d',
     x86_64: '854c2183a47a9ab88db302edb47ac155eb275961020a97eeb10aeac556a07936'
  })

  depends_on 'gtk3'

  def self.patch
    system 'NOCONFIGURE=1 autoreconf -fi'
    system 'filefix'
    system "grep -rl Werror . | xargs sed -i 's,-Wall -Werror,-Wall,g'"
  end

  def self.build
    system "#{CREW_ENV_OPTIONS.sub("CFLAGS='", "CFLAGS='-Wno-deprecated-declarations ").sub("LDFLAGS='",
                                                                                            "LDFLAGS='-lm ")} \
    ./configure \
    #{CREW_OPTIONS} \
    --localstatedir=#{CREW_PREFIX}/var \
    --libexecdir=#{CREW_LIB_PREFIX}/libindicator \
    --sysconfdir=#{CREW_PREFIX}/etc \
    --with-gtk=3 \
    --disable-tests \
    --enable-maintainer-flags=no"
    system "grep -rl lglib-2.0-lm . | xargs sed -i 's,-lglib-2.0-lm,-lglib-2.0 -lm,g'"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
