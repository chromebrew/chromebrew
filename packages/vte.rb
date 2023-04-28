require 'package'

class Vte < Package
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  @_ver = '0.72.1'
  version @_ver
  license 'LGPL-2+ and GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.72.1_armv7l/vte-0.72.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.72.1_armv7l/vte-0.72.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.72.1_x86_64/vte-0.72.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4ed41268c17e5792c69d623fb594af517aa6a390f4098a7d25f832b70900f0d7',
     armv7l: '4ed41268c17e5792c69d623fb594af517aa6a390f4098a7d25f832b70900f0d7',
     x86_64: '9e89895bb13ca14cb09b15f079d9f22d17e5b600ea9063fac151f9db6edd1c6b'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'fribidi' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnutls' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'zlibpkg' # R

  gnome

  def self.build
    system <<~CONFIGURE
      mold -run meson \
      #{CREW_MESON_FNO_LTO_OPTIONS.gsub('-fno-lto', '-fno-lto -fno-stack-protector')} \
      -D_systemd=false \
      -Dfribidi=true \
      -Dgtk3=true \
      -Dgtk4=true \
      -Dgir=false \
      -Dvapi=false \
      builddir
    CONFIGURE
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
