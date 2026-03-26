require 'buildsystems/meson'

class Gtk3 < Meson
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://docs.gtk.org/gtk3/'
  version '3.24.52'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gtk.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd9fa44b3c2edc9e189c61cecbb674d825cafdf67f3b0f84a0275fe87b907ddcd',
     armv7l: 'd9fa44b3c2edc9e189c61cecbb674d825cafdf67f3b0f84a0275fe87b907ddcd',
     x86_64: '7e0d065cec961d5c5eddf20000beab56972b3c4d75714b012d3222cdca0d0b23'
  })

  # L = Logical Dependency, R = Runtime Dependency
  depends_on 'adwaita_fonts' => :logical
  depends_on 'adwaita_icon_theme' => :logical
  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'cups' => :library
  depends_on 'docbook' => :build
  depends_on 'fontconfig' => :library
  depends_on 'fribidi' => :library
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :library
  depends_on 'ghostscript' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' => :build # Do we need this?
  depends_on 'graphite' => :build # Do we need this?
  depends_on 'harfbuzz' => :library
  depends_on 'hicolor_icon_theme' => :logical
  depends_on 'iso_codes' => :build
  depends_on 'json_glib' => :build
  depends_on 'libdeflate' => :build # Do we need this?
  depends_on 'libepoxy' => :library
  depends_on 'libjpeg_turbo' => :build # Do we need this?
  depends_on 'librsvg' => :logical
  depends_on 'libsass' => :build
  depends_on 'libspectre' => :build
  depends_on 'libx11' => :library
  depends_on 'libxcomposite' => :library
  depends_on 'libxcursor' => :library
  depends_on 'libxdamage' => :library
  depends_on 'libxext' => :library
  depends_on 'libxfixes' => :library
  depends_on 'libxi' => :library
  depends_on 'libxinerama' => :library
  depends_on 'libxkbcommon' => :library
  depends_on 'libxrandr' => :library
  depends_on 'mesa' => :build
  depends_on 'pango' => :library
  depends_on 'rest' => :build
  depends_on 'shaderc' => :build
  depends_on 'shared_mime_info' => :logical
  depends_on 'sommelier' => :logical
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'wayland' => :library
  depends_on 'xdg_base' => :logical

  gnome
  no_fhs

  def self.patch
    # Use locally build subprojects
    @deps = %w[cairo librsvg]
    @deps.each do |dep|
      FileUtils.rm_rf ["subprojects/#{dep}", "subprojects/#{dep}.wrap"]
    end
  end

  meson_options '-Dbroadway_backend=true \
      -Ddemos=false \
      -Dexamples=false \
      -Dgtk_doc=false'

  meson_build_extras do
    File.write 'gtk3settings', <<~GTK3_CONFIG_HEREDOC
      [Settings]
      gtk-icon-theme-name = Adwaita
      gtk-fallback-icon-theme = gnome
      gtk-theme-name = Adwaita
      gtk-font-name = Adwaita Sans 11
      gtk-application-prefer-dark-theme = false
      monospace-font-name = Adwaita Mono 11
    GTK3_CONFIG_HEREDOC
  end

  meson_install_extras do
    system "sed -i 's,null,,g'  #{CREW_DEST_LIB_PREFIX}/pkgconfig/gtk*.pc"
    xdg_config_dest_home = File.join(CREW_DEST_PREFIX, '.config')
    FileUtils.install 'gtk3settings', "#{xdg_config_dest_home}/gtk-3.0/settings.ini", mode: 0o644
  end
end
