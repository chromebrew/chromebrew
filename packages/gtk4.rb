require 'buildsystems/meson'

class Gtk4 < Meson
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://www.gtk.org/'
  version '4.22.4-1'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gtk.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25e0f673c9ff2507edd2a29be5f3beb8dee9e05b173d09889856c03f6391e9f3',
     armv7l: '25e0f673c9ff2507edd2a29be5f3beb8dee9e05b173d09889856c03f6391e9f3',
     x86_64: '2dbaae2e2265a8727bbb39a9a39261b0eccbbbed0eb475077b2c7768ff133358'
  })

  depends_on 'adwaita_fonts' => :logical
  depends_on 'adwaita_icon_theme' => :logical
  depends_on 'cairo' => :library
  depends_on 'cups' # R
  depends_on 'docbook' => :build
  depends_on 'fontconfig' => :library
  depends_on 'fribidi' => :library
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :library
  depends_on 'ghostscript' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'glslang' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' => :library
  # depends_on 'gstreamer' # R Let's avoid the glibc 2.29 dep.
  depends_on 'harfbuzz' => :library
  depends_on 'hicolor_icon_theme' => :logical
  depends_on 'intel_media_sdk' => :build if ARCH.eql?('x86_64')
  depends_on 'iso_codes' => :build
  depends_on 'libcloudproviders' => :library
  depends_on 'libepoxy' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'librsvg' => :logical
  depends_on 'libsass' => :build
  depends_on 'libspectre' => :build
  depends_on 'libtiff' => :library
  depends_on 'libx11' => :library
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
  depends_on 'py3_docutils' => :build
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'sassc' => :build
  depends_on 'shaderc' => :build
  depends_on 'shared_mime_info' => :logical
  depends_on 'sommelier' => :logical
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :library
  depends_on 'wayland' => :library
  depends_on 'xdg_base' => :logical
  depends_on 'xvfb' => :build

  gnome
  no_fhs

  def self.patch
    # Don't rebuild packaged subprojects
    %w[cairo librsvg].each do |dep|
      FileUtils.rm_rf "subprojects/#{dep}"
      FileUtils.rm_rf "subprojects/#{dep}.wrap"
    end

    patches = [
      # Fix armv7l build.
      # https://gitlab.gnome.org/GNOME/gtk/-/work_items/8222
      ['https://gitlab.gnome.org/GNOME/gtk/-/merge_requests/9745.diff',
       'ef266dab0038693a26723f438bb40af0c8f0577f4ea817b513ff22b94070eec7']
    ]
    ConvenienceFunctions.patch(patches) if ARCH != 'x86_64' && version.include?('4.22.4')
  end

  meson_options '-Dbroadway-backend=true \
      -Dbuild-demos=false \
      -Dbuild-examples=false \
      -Dbuild-tests=false \
      -Dbuild-testsuite=false \
      -Dcloudproviders=enabled \
      -Dgraphene:default_library=both \
      -Dintrospection=enabled \
      -Dlibsass:default_library=both \
      -Dmedia-gstreamer=disabled \
      -Dmutest:default_library=both \
      -Dprint-cups=auto \
      -Dvulkan=enabled'

  meson_build_extras do
    File.write 'gtk4settings', <<~GTK4_CONFIG_HEREDOC
      [Settings]
      gtk-icon-theme-name = Adwaita
      gtk-theme-name = Adwaita
      gtk-font-name = Cantarell 11
      monospace-font-name = Adwaita Mono 11
    GTK4_CONFIG_HEREDOC
  end

  meson_install_extras do
    xdg_config_dest_home = File.join(CREW_DEST_PREFIX, '.config')
    FileUtils.install 'gtk4settings', "#{xdg_config_dest_home}/gtk-4.0/settings.ini", mode: 0o644
  end
end
