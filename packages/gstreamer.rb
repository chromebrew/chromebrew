require 'package'

class Gstreamer < Package
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.20.0'
  version @_ver
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/gstreamer/gstreamer.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.0_armv7l/gstreamer-1.20.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.0_armv7l/gstreamer-1.20.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.0_i686/gstreamer-1.20.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.0_x86_64/gstreamer-1.20.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9a4806b7ec63fefdc4b5b6383b7b6be98b3b0099fb98cced7ba9e17243955583',
     armv7l: '9a4806b7ec63fefdc4b5b6383b7b6be98b3b0099fb98cced7ba9e17243955583',
       i686: '8cb9f9a360d5da37127c0117c413e85726f9479504919432f166527cea935d3b',
     x86_64: '3fa6ddf28c4fd03777040377d482f224261b859b176fe2a803dc7433edd6dab0'
  })

  depends_on 'elfutils'
  depends_on 'glib'
  depends_on 'gsl'
  depends_on 'gtk3'
  depends_on 'libcap'
  depends_on 'libunwind'

  conflicts_ok # conflicts with orc, gst_plugins_{base,bad}
  def self.build
    @plugins = ''
    case ARCH
    when 'i686'
      @plugins = '-Dgst-plugins-bad:msdk=disabled'
    end
    system "meson #{CREW_MESON_OPTIONS} \
    -Dgpl=enabled \
    -Dtests=disabled #{@plugins}\
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    # system 'make', 'check' # The 'gst/gsttracerrecord' test fails.
  end
end
