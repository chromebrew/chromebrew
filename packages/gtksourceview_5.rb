require 'package'

class Gtksourceview_5 < Package
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  version '5.6.1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtksourceview.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtksourceview_5/5.6.1_armv7l/gtksourceview_5-5.6.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtksourceview_5/5.6.1_armv7l/gtksourceview_5-5.6.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtksourceview_5/5.6.1_i686/gtksourceview_5-5.6.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtksourceview_5/5.6.1_x86_64/gtksourceview_5-5.6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0f8d59796235811fe0293bc1b812a4bb65a717c4ba05a6accd7cd850d1b55208',
     armv7l: '0f8d59796235811fe0293bc1b812a4bb65a717c4ba05a6accd7cd850d1b55208',
       i686: '3a73f4077faa01955a55027b4161def3775b7e3eeb8e11b79fa33d44be8f8b1e',
     x86_64: '025bfd8d5b98858324e8590e0f3fb813b5f7464e63bfe2e346f9925fe153ef69'
  })

  depends_on 'at_spi2_core'
  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'graphene'
  depends_on 'gtk3'
  depends_on 'gtk4'
  depends_on 'harfbuzz'
  depends_on 'libsoup'
  depends_on 'pango'
  depends_on 'vala'
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'pcre2' # R

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-flto=auto/g' meson.build"
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Db_asneeded=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
