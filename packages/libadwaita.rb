require 'package'

class Libadwaita < Package
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  @_ver = '1.2.2'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.2.2_armv7l/libadwaita-1.2.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.2.2_armv7l/libadwaita-1.2.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.2.2_i686/libadwaita-1.2.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.2.2_x86_64/libadwaita-1.2.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '698ecd25158bafb2e9f5f4572df26d9e9e2d12320659a99fa43635682717b161',
     armv7l: '698ecd25158bafb2e9f5f4572df26d9e9e2d12320659a99fa43635682717b161',
       i686: '73d649873455a83191b93f702baafdcef91193a5ea5d83bc5415d0fac030f859',
     x86_64: '2c2316140dc142bc48e5eda47136ffafaf686e164e708bee276e714dca4d6f3f'
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
            -Dtests=false \
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
