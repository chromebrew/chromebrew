require 'package'

class V4l_utils < Package
  description 'The v4l-utils are a series of packages for handling media devices.'
  homepage 'https://www.linuxtv.org/wiki/index.php/V4l-utils'
  @_ver = '1.20.0'
  version @_ver
  compatibility 'all'
  source_url "https://linuxtv.org/downloads/v4l-utils/v4l-utils-#{@_ver}.tar.bz2"
  source_sha256 '956118713f7ccb405c55c7088a6a2490c32d54300dd9a30d8d5008c28d3726f7'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/v4l_utils-1.20.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/v4l_utils-1.20.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/v4l_utils-1.20.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/v4l_utils-1.20.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6020b0b0a9f4bf4659bca79749659210e2bbd30d5099260813847193f17841d3',
     armv7l: '6020b0b0a9f4bf4659bca79749659210e2bbd30d5099260813847193f17841d3',
       i686: '9c6050888763ad102c12647ae0a952db55b2f83074005c1ec5a705b3c8f99031',
     x86_64: '16979812174393e579506611f0f84bf9fc7d26b6d4f3b124c6061c6db007cd7d'
  })

  depends_on 'sdl2_image'
  depends_on 'libglu'
  depends_on 'alsa_lib'

  def self.patch
    system "find . -name '*.pl' -exec sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' {} +"
  end

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --disable-bpf"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
