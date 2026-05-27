require 'buildsystems/meson'

class Gedit < Meson
  description 'GNOME Text Editor'
  homepage 'https://wiki.gnome.org/Apps/Gedit'
  version '50.0'
  license 'GPL-2+ CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gedit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '048b11ecd7b84717a756452a9e1deb178595e3dedc48cbee122847e566ac68cc',
     armv7l: '048b11ecd7b84717a756452a9e1deb178595e3dedc48cbee122847e566ac68cc',
     x86_64: 'd227bea215ada7d86ce6acaf9b0a6759bf71410da97436b6d4c79ef35c4ba69b'
  })

  depends_on 'appstream' => :executable
  depends_on 'cairo' => :library
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gsettings_desktop_schemas' => :logical
  depends_on 'gspell' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libgedit_gtksourceview' => :library
  depends_on 'libpeas' => :library
  depends_on 'pango' => :library
  depends_on 'py3_lxml' => :build
  depends_on 'py3_pygobject' => :build
  depends_on 'tepl_6' => :library
  depends_on 'vala' => :build
  depends_on 'yelp_tools' => :build

  gnome

  meson_options '-Drequire_all_tests=false \
    -Dgtk_doc=false \
    -Duser_documentation=true'
end
