require 'package'

class V4l_utils < Package
  description 'The v4l-utils are a series of packages for handling media devices.'
  homepage 'https://www.linuxtv.org/wiki/index.php/V4l-utils'
  @_ver = '1.20.0'
  version "#{@_ver}-1"
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'all'
  source_url "https://linuxtv.org/downloads/v4l-utils/v4l-utils-#{@_ver}.tar.bz2"
  source_sha256 '956118713f7ccb405c55c7088a6a2490c32d54300dd9a30d8d5008c28d3726f7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/v4l_utils/1.20.0-1_armv7l/v4l_utils-1.20.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/v4l_utils/1.20.0-1_armv7l/v4l_utils-1.20.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/v4l_utils/1.20.0-1_i686/v4l_utils-1.20.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/v4l_utils/1.20.0-1_x86_64/v4l_utils-1.20.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c7048454015dbd6c4b98b1ae19b58030c4f607c28f732ebca0f8ed0e5b130c52',
     armv7l: 'c7048454015dbd6c4b98b1ae19b58030c4f607c28f732ebca0f8ed0e5b130c52',
       i686: '4bd59432a97705ba93146ff3ad91f5f987e820402dc44678212dbd2163b4bdf9',
     x86_64: '4a5f30314e87d470918551e9ade322e94f66d08ecd2c65884f1aec0d039c095a'
  })

  depends_on 'alsa_lib'
  depends_on 'eudev'
  depends_on 'libglu'
  depends_on 'libjpeg'
  depends_on 'mesa'
  depends_on 'qtbase'
  depends_on 'sdl2_image'

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
