require 'package'

class Librhash < Package
  description 'RHash is a console utility for computing and verifying hash sums of files.'
  homepage 'http://rhash.anz.ru/'
  @_ver = '1.4.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rhash/RHash.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librhash/1.4.2_armv7l/librhash-1.4.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librhash/1.4.2_armv7l/librhash-1.4.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librhash/1.4.2_i686/librhash-1.4.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librhash/1.4.2_x86_64/librhash-1.4.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e35ee8b1229d81ebb13041f149dd7a59cdd252ea992cabb1e963b1423d4cc398',
     armv7l: 'e35ee8b1229d81ebb13041f149dd7a59cdd252ea992cabb1e963b1423d4cc398',
       i686: 'd6aa44b3bf5c3330c37dd8135e2161c9ae5cf6b6840000b884f99cd8ab81b050',
     x86_64: 'bd11b33586c3f8d9c0c21ca616aed57a8ebf2faee98e62854df86108193f6c4e'
  })

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}\
            --cc=#{CREW_TGT}-gcc \
            --ar=#{CREW_TGT}-gcc-ar \
            --enable-gettext \
            --enable-openssl \
            --extra-cflags='#{CREW_COMMON_FLAGS}'"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-lib-headers'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-pkg-config'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-lib-so-link'
  end
end
