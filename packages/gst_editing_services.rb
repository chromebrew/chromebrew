require 'package'

class Gst_editing_services < Package
  description 'GStreamer library for creating audio/video editors'
  homepage 'https://gstreamer.freedesktop.org/modules/gst-editing-services.html'
  version '1.18.4'
  license 'LGPL-2.0+'
  compatibility 'all'
  source_url "https://gstreamer.freedesktop.org/src/gst-editing-services/gst-editing-services-#{version}.tar.xz"
  source_sha256 '4687b870a7de18aebf50f45ff572ad9e0138020e3479e02a6f056a0c4c7a1d04'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gst_editing_services/1.18.4_armv7l/gst_editing_services-1.18.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gst_editing_services/1.18.4_armv7l/gst_editing_services-1.18.4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gst_editing_services/1.18.4_i686/gst_editing_services-1.18.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gst_editing_services/1.18.4_x86_64/gst_editing_services-1.18.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b8ec4f105bd65a5d31bad65e992c9fd5cbbd09a1ae8af2fab7b381a103ee3f98',
     armv7l: 'b8ec4f105bd65a5d31bad65e992c9fd5cbbd09a1ae8af2fab7b381a103ee3f98',
       i686: 'ac1f8996db0386e5f4623a912935501a0b63f9cb29566d39295d81559fa62fbc',
     x86_64: '16ec4f39d741dcd52718fd83941dc2528e0a1ce1323ed8ad73b723ccdcd7b0ca'
  })

  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gstreamer'
  depends_on 'gtk_doc' => :build
  depends_on 'pygobject' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Ddoc=disabled \
      -Dvalidate=disabled \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
