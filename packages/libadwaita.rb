require 'package'

class Libadwaita < Package
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  @_ver = '1.3.rc'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.3.rc_armv7l/libadwaita-1.3.rc-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.3.rc_armv7l/libadwaita-1.3.rc-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.3.rc_x86_64/libadwaita-1.3.rc-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9befd825d6c634327d2b7a2a4445f746a5b0651b77247b02f7a867a77f2b071f',
     armv7l: '9befd825d6c634327d2b7a2a4445f746a5b0651b77247b02f7a867a77f2b071f',
     x86_64: '8f1ae1e2195af60a04b962aa5209e101c7945347c1276197f6f63f0fac79bb93'
  })

  depends_on 'cairo'
  depends_on 'fribidi' # R
  depends_on 'gdk_pixbuf'
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'libjpeg'
  depends_on 'libsass' => :build
  depends_on 'pango' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'sassc' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R

  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
            -Dintrospection=enabled \
            -Dexamples=false \
            -Dgtk_doc=false \
            builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test || true'
  end
end
