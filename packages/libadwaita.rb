require 'package'

class Libadwaita < Package
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  version '1.3.2'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.3.2_armv7l/libadwaita-1.3.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.3.2_armv7l/libadwaita-1.3.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libadwaita/1.3.2_x86_64/libadwaita-1.3.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bd6f44c5fd343c1a05d360704b76da19da259fa28326acb0d1493fc1cb324271',
     armv7l: 'bd6f44c5fd343c1a05d360704b76da19da259fa28326acb0d1493fc1cb324271',
     x86_64: '7a60a3ce7880cd8106f2218d25b7c10ad4467d75bdbbe5f936c3c0eaf75a9c44'
  })

  depends_on 'cairo' => :build
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' => :build
  depends_on 'libjpeg' => :build
  depends_on 'libsass' => :build
  depends_on 'pango' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'sassc' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
            -Dintrospection=enabled \
            -Dexamples=false \
            -Dgtk_doc=false \
            builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end
end
