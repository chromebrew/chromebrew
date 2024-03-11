require 'package'

class Gcr_3 < Package
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '3.41.1'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/gcr/-/archive/#{version}/gcr-#{version}.tar.bz2"
  source_sha256 '7e06e86e12aadaac6a72f2ee7eeaaaa6228a0ba3b92cadd50b45c0f05f0d91c6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b2d4cffaf3de2994d1a8f5f7a3b466dc723ef2236761f2753c1e2feeb3fc671',
     armv7l: '6b2d4cffaf3de2994d1a8f5f7a3b466dc723ef2236761f2753c1e2feeb3fc671',
     x86_64: '8af250461b9f5ea95b3198ffb6cb1474b2e0fd7c9571e84420548dd5b10ed7c3'
  })

  depends_on 'cairo'
  depends_on 'desktop_file_utilities'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gnupg'
  depends_on 'graphite'
  depends_on 'gtk3'
  depends_on 'hicolor_icon_theme'
  depends_on 'libgcrypt'
  depends_on 'libjpeg'
  depends_on 'libsecret'
  depends_on 'libxslt'
  depends_on 'pango'
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'glibc' # R
  depends_on 'gtk4' # R
  depends_on 'p11kit' # R
  depends_on 'gcc_lib' # R
  depends_on 'harfbuzz' # R

  conflicts_ok # expected conflicts with gcr_4

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dgtk_doc=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
