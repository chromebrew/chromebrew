require 'package'

class Pixman < Package
  description 'Pixman is a low-level software library for pixel manipulation, providing features such as image compositing and trapezoid rasterization.'
  homepage 'http://www.pixman.org/'
  version '285b9a9'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/pixman/pixman.git'
  git_hashtag '285b9a907caffeb979322e629d4e57aa42061b5a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/285b9a9_armv7l/pixman-285b9a9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/285b9a9_armv7l/pixman-285b9a9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/285b9a9_i686/pixman-285b9a9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/285b9a9_x86_64/pixman-285b9a9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dc326a21317a03af7349f4b8f77210b027ab779e77021cff0a93036b7d341b5a',
     armv7l: 'dc326a21317a03af7349f4b8f77210b027ab779e77021cff0a93036b7d341b5a',
       i686: 'd14290d99d729a89764f39ac004486df18402954af13b0e672b88834ed39e04b',
     x86_64: '7e281e451c1ab1a4dcd4b15f5b7ecd29205786126488c3fdf355d520a0df75ff'
  })

  depends_on 'harfbuzz'

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
