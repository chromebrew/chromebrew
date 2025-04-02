require 'buildsystems/meson'

class Gtk4 < Meson
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://www.gtk.org/'
  version '4.18.3'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gtk.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '15a67f290b01e39ea18a8fe7d16523d32349f199ee82d00a37e4920a2bb70ee4',
     armv7l: '15a67f290b01e39ea18a8fe7d16523d32349f199ee82d00a37e4920a2bb70ee4',
     x86_64: '6bacf6aadf80ccb4a4a4798e16099b75c7148a0bf2f7e2dbbc22253c34918072'
  })

  # L = Logical Dependency, R = Runtime Dependency
  depends_on 'adwaita_fonts' # L
  depends_on 'adwaita_icon_theme' # L
  depends_on 'cairo' # R
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
  depends_on 'glslang' => :build
  # depends_on 'gnome_icon_theme' # L
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  # depends_on 'gstreamer' # R Let's avoid the glibc 2.29 dep.
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme' # L
  depends_on 'intel_media_sdk' => :build if ARCH.eql?('x86_64')
  depends_on 'iso_codes' => :build
  depends_on 'libcloudproviders' # R
  depends_on 'libepoxy' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # L
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
  depends_on 'py3_docutils' => :build
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'sassc' => :build
  depends_on 'shaderc' => :build
  depends_on 'shared_mime_info' # L
  depends_on 'sommelier' # L
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'wayland' # R
  depends_on 'xdg_base' # L
  depends_on 'zlib' # R

  gnome
  no_fhs

  def self.patch
    # Don't rebuild packaged subprojects
    %w[cairo librsvg].each do |dep|
      FileUtils.rm_rf "subprojects/#{dep}"
      FileUtils.rm_rf "subprojects/#{dep}.wrap"
    end
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
