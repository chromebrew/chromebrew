require 'package'

class Gedit < Package
  description 'GNOME Text Editor'
  homepage 'https://wiki.gnome.org/Apps/Gedit'
  version '40.1'
  license 'GPL-2+ CC-BY-SA-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gedit.git'
  git_hashtag version
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'd00004e8fe0b7f2f9c1884f4f7657b208ac504cf9b19ef033f58559b4683588f',
     armv7l: 'd00004e8fe0b7f2f9c1884f4f7657b208ac504cf9b19ef033f58559b4683588f',
     x86_64: 'dc1aee9657dfa305d79fd9f4c582515886aeb6254d06794271997385d5f3060d'
  })

  depends_on 'amtk' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'gsettings_desktop_schemas' # L
  depends_on 'gspell' # R
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'gtksourceview_4' # R
  depends_on 'libpeas' # R
  depends_on 'pango' # R
  depends_on 'pygobject'
  depends_on 'tepl_6' # R
  depends_on 'vala' => :build
  depends_on 'yelp_tools' => :build

  def self.patch
    # Source has libgd repo as submodule
    @git_dir = 'subprojects/libgd'
    @git_hash = 'c7c7ff4e05d3fe82854219091cf116cce6b19de0'
    @git_url = 'https://gitlab.gnome.org/GNOME/libgd.git'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'
    end
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Drequire_all_tests=false \
    -Duser_documentation=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
