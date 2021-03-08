require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.10.0'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://github.com/intel/libva/releases/download/#{@_ver}/libva-#{@_ver}.tar.bz2"
  source_sha256 'fa81e35b50d9818fce5ec9eeeeff08a24a8864ceeb9a5c8e7ae4446eacfc0236'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.10.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.10.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.10.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.10.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f15abb28fabd3705d576c431e0f33f4e0d66d4d91265dc48c85c0025bdf27718',
     armv7l: 'f15abb28fabd3705d576c431e0f33f4e0d66d4d91265dc48c85c0025bdf27718',
       i686: '67c020e5b9d42b3d1ad30bbda26ade95bc50c2e2d32d61c01953d2bc85caf8d1',
     x86_64: '6c226597b4cce0c915a83e493fe43d470b31b87c4a21b74bb17cfcdbcb683c77'
  })

  depends_on 'libdrm'

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
