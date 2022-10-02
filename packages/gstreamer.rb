require 'package'

class Gstreamer < Package
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.20.3'
  version "#{@_ver}-1"
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/gstreamer/gstreamer.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.3-1_armv7l/gstreamer-1.20.3-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.3-1_armv7l/gstreamer-1.20.3-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.3-1_i686/gstreamer-1.20.3-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gstreamer/1.20.3-1_x86_64/gstreamer-1.20.3-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e841406957a963846da6a63864001c8165b7afa83abcc73ec1a86b939a3c9462',
     armv7l: 'e841406957a963846da6a63864001c8165b7afa83abcc73ec1a86b939a3c9462',
       i686: 'f2ac4f825c4b078617ab15ca590dfe1dbd4fb644c87ad984726cb28f70117a18',
     x86_64: '23752e3b1a1cb4feb2c3c0a7286833ef2d49598ab615ef93f0874b535e4d1e06'
  })

  depends_on 'elfutils'
  depends_on 'glib'
  depends_on 'gsl'
  depends_on 'gtk3'
  depends_on 'libcap'
  depends_on 'libjpeg'
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
