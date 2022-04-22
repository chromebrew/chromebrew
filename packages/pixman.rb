require 'package'

class Pixman < Package
  description 'Pixman is a low-level software library for pixel manipulation, providing features such as image compositing and trapezoid rasterization.'
  homepage 'http://www.pixman.org/'
  version '285b9a9-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/pixman/pixman.git'
  git_hashtag '285b9a907caffeb979322e629d4e57aa42061b5a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/285b9a9-1_armv7l/pixman-285b9a9-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/285b9a9-1_armv7l/pixman-285b9a9-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/285b9a9-1_i686/pixman-285b9a9-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/285b9a9-1_x86_64/pixman-285b9a9-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a7ec280be6f2dfab3576a91dcd9ea44c62bed128606bf9cae996f7035201f255',
     armv7l: 'a7ec280be6f2dfab3576a91dcd9ea44c62bed128606bf9cae996f7035201f255',
       i686: '8d8363d7502f4207f3f093e10a4853bd2cec872d084ea019cbd2b5a91294e9bd',
     x86_64: '6f9d90580d13341db34078d1d3c4d03f2f746c471bb9a8aa35679663cf5a26b9'
  })

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dgtk=disabled \
    -Dlibpng=disabled \
    -Dtests=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
