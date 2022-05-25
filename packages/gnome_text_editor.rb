require 'package'

class Gnome_text_editor < Package
  description 'GNOME Text Editor'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-text-editor'
  version '44.0'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-text-editor.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_text_editor/44.0_armv7l/gnome_text_editor-44.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_text_editor/44.0_armv7l/gnome_text_editor-44.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_text_editor/44.0_x86_64/gnome_text_editor-44.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '46d478cbb5457ba5136fcbd440e3860c785af49264a90d1b75aee6e49f4a3ebf',
     armv7l: '46d478cbb5457ba5136fcbd440e3860c785af49264a90d1b75aee6e49f4a3ebf',
     x86_64: 'd0ce04a091262e7e67729eaa9830d5fefb3a93986487d93dfd4622636f0c1d9b'
  })

  depends_on 'desktop_file_utils' => :build
  depends_on 'editorconfig_core_c' # R
  depends_on 'enchant' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gspell' => :build
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'gtksourceview_5' # R
  depends_on 'harfbuzz' # R
  depends_on 'ibus' => :build
  depends_on 'icu4c' # R
  depends_on 'libadwaita' # R
  depends_on 'libpeas' => :build
  depends_on 'pango' # R
  depends_on 'pcre' => :build
  depends_on 'pygobject' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'yelp_tools' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
            builddir"
    system 'meson configure --no-pager builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
