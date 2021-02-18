require 'package'

class Gst_editing_services < Package
  description 'GStreamer library for creating audio/video editors'
  homepage 'https://gstreamer.freedesktop.org/modules/gst-editing-services.html'
  @_ver = '1.18.3'
  version @_ver
  compatibility 'all'
  source_url "https://gstreamer.freedesktop.org/src/gst-editing-services/gst-editing-services-#{@_ver}.tar.xz"
  source_sha256 '8ae139b13b1646a20ba63b0b90877d35813e24cd87642d325e751fc7cb175e20'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_editing_services-1.18.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gst_editing_services-1.18.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gst_editing_services-1.18.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gst_editing_services-1.18.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '636d3e41a67797fe95af7a17688f40124daea90fef63d8ce5caa439be65f808e',
     armv7l: '636d3e41a67797fe95af7a17688f40124daea90fef63d8ce5caa439be65f808e',
       i686: 'e437d3d396bcc07b18f757b960ca30bd81842567de229dead0affb32c87ecffa',
     x86_64: '4c906fb4b499772f0272894c525bcefa60d15d7bcbf328c5dd2a3a304ff82c0f'
  })

  depends_on 'gst_plugins_base'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'pygobject' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      -Ddoc=disabled \
      -Dvalidate=disabled \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
