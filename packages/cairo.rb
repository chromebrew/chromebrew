require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.17.8-d68eb3c'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag 'd68eb3c8df22694e9f25bb62b9cfa28b488f5a29'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.8-af5a25a_i686/cairo-1.17.8-af5a25a-chromeos-i686.tar.zst',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.8-d68eb3c_armv7l/cairo-1.17.8-d68eb3c-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.8-d68eb3c_armv7l/cairo-1.17.8-d68eb3c-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.8-d68eb3c_x86_64/cairo-1.17.8-d68eb3c-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
       i686: 'e5e7549bbedbb0dd1f49488f253deb11b504147e39adf99733ce5c664d237022',
    aarch64: '1d5c582b9520310fc02ff59dc37eaf2b9b745710b0d08a623a8389626272932b',
     armv7l: '1d5c582b9520310fc02ff59dc37eaf2b9b745710b0d08a623a8389626272932b',
     x86_64: '13bae402fc0e840ed26a5681be2fc98ef74febd98839aafe513baa8c682a741c'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'libpng' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxrender' # R
  depends_on 'lzo' # R
  depends_on 'mesa' => :build
  depends_on 'pixman' # R
  depends_on 'zlibpkg' # R

  conflicts_ok # because this overwrites the limited cairo from harfbuzz

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dxlib-xcb=enabled \
    -Dtee=enabled \
    -Dtests=disabled \
    builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
