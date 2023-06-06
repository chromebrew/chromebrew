require 'package'

class Gtk4 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk4/'
  @_ver = '4.10.4'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gtk.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk4/4.10.4_armv7l/gtk4-4.10.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk4/4.10.4_armv7l/gtk4-4.10.4-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk4/4.10.4_x86_64/gtk4-4.10.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6cce02639e276e90d691968194a672d96546387cea423b6bb4e936af9edd3ed6',
     armv7l: '6cce02639e276e90d691968194a672d96546387cea423b6bb4e936af9edd3ed6',
     x86_64: '430e515ecaf3aec786a2062acfaa1cd451a1fd6a3d2e764816df1d9a709d2391'
  })

  # L = Logical Dependency, R = Runtime Dependency
  depends_on 'adwaita_icon_theme' # L
  depends_on 'cairo' # R
  depends_on 'cantarell_fonts' # L
  depends_on 'cups' # R
  depends_on 'docbook' => :build
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'ghostscript' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnome_icon_theme' # L
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gstreamer' # R
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme' # L
  depends_on 'intel_media_sdk' => :build if ARCH.eql?('x86_64')
  depends_on 'iso_codes' => :build
  depends_on 'libcloudproviders' # R
  depends_on 'libepoxy' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libsass' => :build
  depends_on 'libspectre' => :build
  depends_on 'libtiff' # R
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
  depends_on 'libxrender' # R
  depends_on 'mesa' => :build
  depends_on 'pango' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'sassc' => :build
  depends_on 'shared_mime_info' # L
  depends_on 'sommelier' # L
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'wayland' # R
  depends_on 'xdg_base' # L
  depends_on 'zlibpkg' # R

  gnome
  no_fhs

  def self.patch
    # Don't rebuild packaged subprojects
    %w[cairo librsvg].each do |dep|
      FileUtils.rm_rf "subprojects/#{dep}"
      FileUtils.rm_rf "subprojects/#{dep}.wrap"
    end
  end

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
      -Dbroadway-backend=true \
      -Dbuild-examples=false \
      -Dbuild-tests=false \
      -Dbuild-testsuite=false \
      -Ddemos=false \
      -Dintrospection=enabled \
      -Dgraphene:default_library=both \
      -Dlibsass:default_library=both \
      -Dmutest:default_library=both \
      -Dcloudproviders=enabled \
      -Dvulkan=enabled \
      -Dprint-cups=auto \
      builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
    File.write 'gtk4settings', <<~GTK4_CONFIG_HEREDOC
      [Settings]
      gtk-icon-theme-name = Adwaita
      gtk-theme-name = Adwaita
      gtk-font-name = Cantarell 11
    GTK4_CONFIG_HEREDOC
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    @xdg_config_dest_home = "#{CREW_DEST_PREFIX}/.config"
    FileUtils.install 'gtk4settings', "#{@xdg_config_dest_home}/gtk-4.0/settings.ini", mode: 0o644
  end
end
