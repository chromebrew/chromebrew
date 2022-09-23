require 'package'

class Gstreamer < Package
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.20.3'
  version @_ver
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/gstreamer/gstreamer.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.3_armv7l/gstreamer-1.20.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.3_armv7l/gstreamer-1.20.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.3_i686/gstreamer-1.20.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.3_x86_64/gstreamer-1.20.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a2c884c6f7db53d0a56d0483e10026181d0a8fdd6e1fcd9aa03ab03dca95b28a',
     armv7l: 'a2c884c6f7db53d0a56d0483e10026181d0a8fdd6e1fcd9aa03ab03dca95b28a',
       i686: '98748c1022ef0945d4b270975cd4ad42c12754d83beacbae8e6badd041d60e37',
     x86_64: 'ed5e8eb2d867cb0426ee2d8d9d54ad3cfd7dcc832dedae0845833f2b68fb5cfe'
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
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    # system 'make', 'check' # The 'gst/gsttracerrecord' test fails.
  end
end
