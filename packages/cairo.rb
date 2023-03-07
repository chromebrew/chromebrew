require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.17.8-af5a25a'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag 'af5a25a7f19e8fe6242c50f17bd246f98b6fdf87'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.8-af5a25a_armv7l/cairo-1.17.8-af5a25a-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.8-af5a25a_armv7l/cairo-1.17.8-af5a25a-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.8-af5a25a_i686/cairo-1.17.8-af5a25a-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.8-af5a25a_x86_64/cairo-1.17.8-af5a25a-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9e8b8dc46bc173ca21a45b5f0c500c96e1cfcadd1985548568adecb25ff96ec0',
     armv7l: '9e8b8dc46bc173ca21a45b5f0c500c96e1cfcadd1985548568adecb25ff96ec0',
       i686: 'e5e7549bbedbb0dd1f49488f253deb11b504147e39adf99733ce5c664d237022',
     x86_64: 'ded85aef72c1c263d094b18a95201cd9e933c39b880e6ff41782c14090b8a9be'
  })

  depends_on 'gcc' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
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
