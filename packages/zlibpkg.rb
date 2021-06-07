require 'package'

class Zlibpkg < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'http://www.zlib.net/'
  @_ver = '1.2.11'
  version "#{@_ver}-5"
  license 'BSD'
  compatibility 'all'
  source_url "http://www.zlib.net/zlib-#{@_ver}.tar.gz"
  source_sha256 'c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.11-5_armv7l/zlibpkg-1.2.11-5-chromeos-armv7l.tpxz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.11-5_armv7l/zlibpkg-1.2.11-5-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.11-5_i686/zlibpkg-1.2.11-5-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.11-5_x86_64/zlibpkg-1.2.11-5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b80e7c60c1a250f7d64289ab376547ba93f29e12cdaa3ae4a1a3a00b7d4ad450',
    armv7l: 'b80e7c60c1a250f7d64289ab376547ba93f29e12cdaa3ae4a1a3a00b7d4ad450',
    i686: '96bc24d5d6651147fcd99e08740bfa71335aa8b51506cbb580f13cad784c2fb2',
    x86_64: '475af7ff9074abbe8fbb52f686dbf8f43f4c9dc1987a4231ae85c56d15d246c7'
  })

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      ./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
