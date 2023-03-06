require 'package'

class Gtk3 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  @_ver = '3.24.34-80d8970'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtk.git'
  git_hashtag '80d8970072650c7715c62bef933f8d332525c6c0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk3/3.24.34-80d8970_armv7l/gtk3-3.24.34-80d8970-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk3/3.24.34-80d8970_armv7l/gtk3-3.24.34-80d8970-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk3/3.24.34-80d8970_i686/gtk3-3.24.34-80d8970-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk3/3.24.34-80d8970_x86_64/gtk3-3.24.34-80d8970-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '817fabb61fc657cd6521da1daf75b59c4e05c3bb789cf2f288891f24e51cf6c4',
     armv7l: '817fabb61fc657cd6521da1daf75b59c4e05c3bb789cf2f288891f24e51cf6c4',
       i686: '559f507efe16ef35f24fb9ca36fc01ad903de6c86039d298a7570e0f4149ac39',
     x86_64: '1abe7f4880f0c4380413bf39cfea75621c47907047016210d620d988b95c5dc0'
  })

  # L = Logical Dependency, R = Runtime Dependency
  depends_on 'adwaita_icon_theme' # L
  depends_on 'at_spi2_core' # R
  depends_on 'at_spi2_core' # R
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
  depends_on 'rest' # R
  depends_on 'shared_mime_info' # L
  depends_on 'sommelier' # L
  depends_on 'valgrind' => :build
  depends_on 'wayland' # R
  depends_on 'xdg_base' # L
  depends_on 'glibc' # R
  gnome

  def self.patch
    # Use locally build subprojects
    @deps = %w[cairo librsvg]
    @deps.each do |dep|
      FileUtils.rm_rf ["subprojects/#{dep}", "subprojects/#{dep}.wrap"]
    end
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
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
