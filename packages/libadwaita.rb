require 'package'

class Libadwaita < Package
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  @_ver = '1.3.beta'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.3.beta_armv7l/libadwaita-1.3.beta-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.3.beta_armv7l/libadwaita-1.3.beta-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.3.beta_i686/libadwaita-1.3.beta-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.3.beta_x86_64/libadwaita-1.3.beta-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e5cd5435b81fd35bc68767f3e5f64984afe5bdf4b12edff8a79ecb595a824f65',
     armv7l: 'e5cd5435b81fd35bc68767f3e5f64984afe5bdf4b12edff8a79ecb595a824f65',
       i686: 'f8014d089f29c90e50deb66b1c909d6cf0ea64c11fd0b6874ed2811e938f3648',
     x86_64: '1fbbb78a8db44da2d889b92966635100e40ab46503f606083fb77370597a94d0'
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
