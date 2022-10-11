require 'package'

class Gtk4 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk4/'
  @_ver = '4.8.1'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version "#{@_ver}-1"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtk.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk4/4.8.1-1_armv7l/gtk4-4.8.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk4/4.8.1-1_armv7l/gtk4-4.8.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk4/4.8.1-1_i686/gtk4-4.8.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk4/4.8.1-1_x86_64/gtk4-4.8.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '07081fc821be22af8b3eea625923cafa6c906b868972c539ce5ee27a4b7b99d5',
     armv7l: '07081fc821be22af8b3eea625923cafa6c906b868972c539ce5ee27a4b7b99d5',
       i686: '5a496bb4dc3b9c406efd674a32559652c3bace4eac19a8b8b36588a5b0abe1b7',
     x86_64: '59d373eed4ab87eaf20c6bbeb39f5679e00cb80b3fe7727f04c455e4ba93a4f7'
  })

  # L = Logical Dependency, R = Runtime Dependency
  depends_on 'docbook' => :build
  depends_on 'ghostscript' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'intel_media_sdk' => :build if ARCH.eql?('x86_64')
  depends_on 'iso_codes' => :build
  depends_on 'libsass' => :build
  depends_on 'libspectre' => :build
  depends_on 'mesa' => :build
  depends_on 'valgrind' => :build
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'adwaita_icon_theme' # L
  depends_on 'cantarell_fonts' # L
  depends_on 'gnome_icon_theme' # L
  depends_on 'hicolor_icon_theme' # L
  depends_on 'shared_mime_info' # L
  depends_on 'xdg_base' # L
  depends_on 'cairo' # R
  depends_on 'cups' # R
  depends_on 'fontconfig' # R
  depends_on 'fribidi' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'graphene' # R
  depends_on 'gstreamer' # R
  depends_on 'harfbuzz' # R
  depends_on 'libepoxy' # R
  depends_on 'libx11' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxcursor' # R
  depends_on 'libxdamage' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxi' # R
  depends_on 'libxinerama' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxrandr' # R
  depends_on 'pango' # R
  depends_on 'sassc' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'wayland' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  gnome

  def self.patch
    case ARCH
    when 'i686'
      system "sed -i 's,#include <fcntl.h>,#include <linux/fcntl.h>,' gdk/wayland/cursor/os-compatibility.c"
      system "sed -i 's/#define HAVE_MEMFD_CREATE/#define HAVE_MEMFD_CREATE_NO/' gdk/wayland/cursor/os-compatibility.c"
    end
    # Don't rebuild packaged subprojects
    @deps = %w[cairo librsvg]
    @deps.each do |dep|
      FileUtils.rm_rf "subprojects/#{dep}"
      FileUtils.rm_rf "subprojects/#{dep}.wrap"
    end
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dbroadway-backend=true \
      -Dbuild-examples=false \
      -Dbuild-tests=false \
      -Ddemos=false\
      -Dgraphene:default_library=both \
      -Dlibsass:default_library=both \
      -Dmutest:default_library=both \
      -Dvulkan=enabled \
      build"
    system 'meson configure build'
    system 'ninja -C build'
    @gtk4settings = <<~GTK4_CONFIG_HEREDOC
      [Settings]
      gtk-icon-theme-name = Adwaita
      gtk-theme-name = Adwaita
      gtk-font-name = Cantarell 11
    GTK4_CONFIG_HEREDOC
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/gtk-4.0"
    File.write("#{CREW_DEST_PREFIX}/etc/gtk-4.0/settings.ini", @gtk4settings)
  end
end
