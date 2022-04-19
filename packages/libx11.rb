require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.7.5'
  license 'custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libx11.git'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.5_armv7l/libx11-1.7.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.5_armv7l/libx11-1.7.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.5_i686/libx11-1.7.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.5_x86_64/libx11-1.7.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '929405c796f836e64620cb1d751c9651a71387467a84302b352a41a953872c16',
     armv7l: '929405c796f836e64620cb1d751c9651a71387467a84302b352a41a953872c16',
       i686: '32fd6f90c8dc7886c23063ba59fa5858ddae011244ec8da1c8361db6c70c501d',
     x86_64: 'adbf1fda20914f22186dfacbe96d549a46319e58c3c7869530e3ab6b860b96b8'
  })
  git_hashtag "libX11-#{version}"

  depends_on 'llvm' => :build
  depends_on 'xorg_proto'
  depends_on 'libxcb'
  depends_on 'libxdmcp'
  depends_on 'libxtrans'
  patchelf

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
