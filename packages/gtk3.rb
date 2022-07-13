require 'package'

class Gtk3 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  @_ver = '3.24.34'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtk.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk3/3.24.34_armv7l/gtk3-3.24.34-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk3/3.24.34_armv7l/gtk3-3.24.34-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk3/3.24.34_i686/gtk3-3.24.34-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk3/3.24.34_x86_64/gtk3-3.24.34-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '40ec61e2bbde4b2bcb86726ab33d839f5210d345e60e0e493e990e5a32913093',
     armv7l: '40ec61e2bbde4b2bcb86726ab33d839f5210d345e60e0e493e990e5a32913093',
       i686: 'db54cbdcca99bb45075583ee50ca9b1cf9513490f5dd99bf504ac168e0947bdf',
     x86_64: '1790362977831f3d2879d92b6a50db35b2a3155e757e3a27c1a70df750881930'
  })

  # L = Logical Dependency, R = Runtime Dependency
  depends_on 'adwaita_icon_theme' # L
  depends_on 'atk' # R
  depends_on 'at_spi2_atk' # R
  depends_on 'cairo' # R
  depends_on 'cantarell_fonts' # L
  depends_on 'cups' # R
  depends_on 'docbook' => :build
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'ghostscript' => :build
  depends_on 'glib' # R
  depends_on 'gnome_icon_theme' # L
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' => :build # Do we need this?
  depends_on 'graphite' => :build # Do we need this?
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme' # L
  depends_on 'iso_codes' => :build
  depends_on 'json_glib' # R
  depends_on 'libdeflate' => :build # Do we need this?
  depends_on 'libepoxy' # R
  depends_on 'libjpeg' => :build # Do we need this?
  depends_on 'libsass' => :build
  depends_on 'libspectre' => :build
  depends_on 'libx11' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxcursor' # R
  depends_on 'libxdamage' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxinerama' # R
  depends_on 'libxi' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxrandr' # R
  depends_on 'mesa' => :build
  depends_on 'pango' # R
  depends_on 'py3_six' => :build # Do we need this?
  depends_on 'rest' # R
  depends_on 'shared_mime_info' # L
  depends_on 'valgrind' => :build
  depends_on 'wayland' # R
  depends_on 'xdg_base' # L
  gnome

  def self.patch
    # Use locally build subprojects
    @deps = %w[cairo librsvg]
    @deps.each do |dep|
      FileUtils.rm_rf "subprojects/#{dep}"
      FileUtils.rm_rf "subprojects/#{dep}.wrap"
    end
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dbroadway_backend=true \
      -Ddemos=false \
      -Dexamples=false \
      -Dgtk_doc=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
    @gtk3settings = <<~GTK3_CONFIG_HEREDOC
      [Settings]
      gtk-icon-theme-name = Adwaita
      gtk-fallback-icon-theme = gnome
      gtk-theme-name = Adwaita
      gtk-font-name = Cantarell 11
      gtk-application-prefer-dark-theme = false
    GTK3_CONFIG_HEREDOC
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    system "sed -i 's,null,,g'  #{CREW_DEST_LIB_PREFIX}/pkgconfig/gtk*.pc"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/gtk-3.0"
    File.write("#{CREW_DEST_PREFIX}/etc/gtk-3.0/settings.ini", @gtk3settings)
  end
end
