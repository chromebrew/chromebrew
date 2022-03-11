require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.17.5-ec54603'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag 'ec54603366a39a5ad12c489aaf0bbb85859fa7a9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.5-ec54603_armv7l/cairo-1.17.5-ec54603-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.5-ec54603_armv7l/cairo-1.17.5-ec54603-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.5-ec54603_i686/cairo-1.17.5-ec54603-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.5-ec54603_x86_64/cairo-1.17.5-ec54603-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1afe2c4afb826e35c549f786db7983a961a7cb1ca14d079ee448463949ad4626',
     armv7l: '1afe2c4afb826e35c549f786db7983a961a7cb1ca14d079ee448463949ad4626',
       i686: 'cbd2b8faf20bbc08751be0e2e37d38d8df6007b93b46ec82c06a8878c730a06e',
     x86_64: 'bf0cf34ce1bced53bb91aa0d43c0769c436afea02c78773d2ccdb1ad40c4f105'
  })

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'glib'
  depends_on 'harfbuzz'
  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxrender'
  depends_on 'lzo'
  depends_on 'mesa'
  depends_on 'pixman'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dgl-backend=auto \
    -Dglesv3=enabled \
    -Dxlib-xcb=enabled \
    -Dtee=enabled \
    -Dtests=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
