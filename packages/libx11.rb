require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.7.3.1'
  license 'custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libx11.git'
  git_hashtag "libX11-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.3.1_armv7l/libx11-1.7.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.3.1_armv7l/libx11-1.7.3.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.3.1_i686/libx11-1.7.3.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.3.1_x86_64/libx11-1.7.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '23bdd5b1b635e3cca9d434b7f6d60057e8c16bcd7edfbf612337fc16382f9449',
     armv7l: '23bdd5b1b635e3cca9d434b7f6d60057e8c16bcd7edfbf612337fc16382f9449',
       i686: 'd7ac187627f55b2bdf5052d68b03dbe107ac70fe4378ecabb68aab4d42ef3ba2',
     x86_64: 'c84e961c5e4fd95e684a2c2d2f6a041bdb5a0289f66eb414f99e184f70a3c42d'
  })

  depends_on 'llvm' => :build
  depends_on 'xorg_proto'
  depends_on 'libxcb'
  depends_on 'libxdmcp'
  depends_on 'libxtrans'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
