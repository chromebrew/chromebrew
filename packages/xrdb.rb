require 'package'

class Xrdb < Package
  description 'xrdb - X server resource database utility'
  homepage 'https://x.org'
  @_ver = '1.2.1'
  version @_ver
  license 'custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xrdb.git'
  git_hashtag "xrdb-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xrdb/1.2.1_armv7l/xrdb-1.2.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xrdb/1.2.1_armv7l/xrdb-1.2.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xrdb/1.2.1_i686/xrdb-1.2.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xrdb/1.2.1_x86_64/xrdb-1.2.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fd449dbef069f5f608d0e5a5d6b7da6104a4e7284b5a1a5e22fdb6d7a21ebc65',
     armv7l: 'fd449dbef069f5f608d0e5a5d6b7da6104a4e7284b5a1a5e22fdb6d7a21ebc65',
       i686: 'f1eae836a2c769f2b383cc3c21d2d2e6307f32019a66ebce33ace94755ac3151',
     x86_64: 'f7f4003249dba8c91b80cf4c462506a6ca7e11deb3891fca79df735925c36ca4'
  })

  depends_on 'libxmu'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
