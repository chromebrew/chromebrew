require 'package'

class Libice < Package
  description 'X.org X Inter Client Exchange Library'
  homepage 'http://www.x.org'
  version '1.0.10'
  license 'X11'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libICE-1.0.10.tar.gz'
  source_sha256 '1116bc64c772fd127a0d0c0ffa2833479905e3d3d8197740b3abd5f292f22d2d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libice/1.0.10_armv7l/libice-1.0.10-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libice/1.0.10_armv7l/libice-1.0.10-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libice/1.0.10_i686/libice-1.0.10-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libice/1.0.10_x86_64/libice-1.0.10-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '47981dc8ab3d21b12cdd36f69ca5c81da33d87c11da279a6cff8f37b146538c8',
     armv7l: '47981dc8ab3d21b12cdd36f69ca5c81da33d87c11da279a6cff8f37b146538c8',
       i686: 'acebe9d03d26e8fa5e47079d3f68346fd8af17b0820ad2f6738e9c1b153f9295',
     x86_64: 'af7d070f98f27176345c0735a53a8fd1434d8843683dc282180091dde7efc030'
  })

  depends_on 'libxtrans'
  depends_on 'libx11'
  depends_on 'libbsd'
  patchelf

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
