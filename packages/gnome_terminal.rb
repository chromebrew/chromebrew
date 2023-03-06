require 'package'

class Gnome_terminal < Package
  description 'The GNOME Terminal Emulator'
  homepage 'https://wiki.gnome.org/Apps/Terminal'
  @_ver = '3.46.8'
  version @_ver
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-terminal.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.46.8_armv7l/gnome_terminal-3.46.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.46.8_armv7l/gnome_terminal-3.46.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.46.8_i686/gnome_terminal-3.46.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.46.8_x86_64/gnome_terminal-3.46.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '38a6da5d7cf8f4a00f72f6b70341db0dd4ca123724cc41e77d3a01c1a6f45a16',
     armv7l: '38a6da5d7cf8f4a00f72f6b70341db0dd4ca123724cc41e77d3a01c1a6f45a16',
       i686: '70ea134e60c8bb05e627eaf86bb12183553dec7df7c8b3268dd179f0cdb7b8e2',
     x86_64: '1f7e3dd155ef327748ec1efabcd2380c5782d6a358f082f3f11b56043bb1a95b'
  })

  depends_on 'adobe_source_code_pro_fonts' # (Needed for monospace fonts)
  depends_on 'atk_spi2_core' # R
  depends_on 'at_spi2_core' # R
  depends_on 'dconf' => :build
  depends_on 'dbus' # L
  depends_on 'desktop_file_utilities' => :build
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gsettings_desktop_schemas'
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'libx11' # R
  depends_on 'pango' # R
  depends_on 'util_linux' # R
  depends_on 'vte' # R
  depends_on 'yelp_tools' => :build

  gnome

  def self.build
    system "meson setup #{CREW_MESON_FNO_LTO_OPTIONS} \
    --default-library=both \
    -Ddocs=false \
    -Dsearch_provider=false \
    -Dnautilus_extension=false \
    -Dlocalstatedir=#{CREW_PREFIX}/var/local \
    -Dsharedstatedir=#{CREW_PREFIX}/var/local/lib \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    puts 'gnome-terminal should be launched using "dbus-launch gnome-terminal"'.lightblue
  end
end
