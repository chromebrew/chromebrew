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
    aarch64: '59805811b7e2933f16bd2114d865802ffc42ea025f353c7ae70326443d502a9e',
     armv7l: '59805811b7e2933f16bd2114d865802ffc42ea025f353c7ae70326443d502a9e',
       i686: '32a3acd47df5deb05dc97177438d9ef6d7c0b66940d82e6e9a5206ebec6a6bba',
     x86_64: '60784cf7c9145aaf4c3f98e705ec4c0b2d1d6468957cee41f12f851731431a5a'
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
