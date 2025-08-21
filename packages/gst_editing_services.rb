require 'package'

class Gst_editing_services < Package
  description 'GStreamer library for creating audio/video editors'
  homepage 'https://gstreamer.freedesktop.org/modules/gst-editing-services.html'
  version '1.26.5'
  license 'LGPL-2.0+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://gstreamer.freedesktop.org/src/gst-editing-services/gst-editing-services-#{version}.tar.xz"
  source_sha256 '734900944f90ece5e2f3983c335178fda50023fe342aa75ecd9d8a9c38b64d9e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b8ec4f105bd65a5d31bad65e992c9fd5cbbd09a1ae8af2fab7b381a103ee3f98',
     armv7l: 'b8ec4f105bd65a5d31bad65e992c9fd5cbbd09a1ae8af2fab7b381a103ee3f98',
     x86_64: '16ec4f39d741dcd52718fd83941dc2528e0a1ce1323ed8ad73b723ccdcd7b0ca'
  })

  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gstreamer'
  depends_on 'gtk_doc' => :build
  depends_on 'py3_pygobject' => :build

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
