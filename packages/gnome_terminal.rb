require 'package'

class Gnome_terminal < Package
  description 'The GNOME Terminal Emulator'
  homepage 'https://wiki.gnome.org/Apps/Terminal'
  @_ver = '3.48.0'
  version @_ver
  license 'GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-terminal.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.48.0_armv7l/gnome_terminal-3.48.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.48.0_armv7l/gnome_terminal-3.48.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.48.0_x86_64/gnome_terminal-3.48.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0f2aaae2cb3b2bcfcc00df7e03213a079a74b3cd9e1f6c26507fde0ef2a209b3',
     armv7l: '0f2aaae2cb3b2bcfcc00df7e03213a079a74b3cd9e1f6c26507fde0ef2a209b3',
     x86_64: '5b1844c860a4b5b05da151525d045b22b8668c9150fac8c854e538d46604182e'
  })

  depends_on 'adobe_source_code_pro_fonts' # (Needed for monospace fonts)
  depends_on 'at_spi2_core' # R
  depends_on 'dbus' # L
  depends_on 'dconf' => :build
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
