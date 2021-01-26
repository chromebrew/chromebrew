require 'package'

class Pipewire < Package
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipwire.org'
  @_ver = '0.3.20'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/PipeWire/pipewire/archive/#{@_ver}.tar.gz"
  source_sha256 '7da6d8283aea6b37480e626b57f23b2bf70d6b73470105a5853b213786d1c097'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.20-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.20-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.20-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '1ffffd3f745591bd1b5e28032a7eec6c022e00822d1e42759f395a3a74b345c8',
      armv7l: '1ffffd3f745591bd1b5e28032a7eec6c022e00822d1e42759f395a3a74b345c8',
        i686: 'ca8a88acbadcaf93644f12e6c64eb120547e01c1139006a690aa8b21c2304314',
      x86_64: 'd5ada28c243897abcd44677f2c31531bdb06dcf9503f2fbc85aec2fcdd2b4546',
  })

  depends_on 'gsettings_desktop_schemas'
  depends_on 'alsa_plugins' => :build
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'jack'
  depends_on 'eudev'
  depends_on 'vulkan_headers'
  depends_on 'mesa'

  def self.build
    system "meson \
      #{CREW_MESON_LTO_OPTIONS} \
      -Dbluez5=false \
      -Dbluez5-backend-native=false \
      -Dbluez5-backend-ofono=false \
      -Dbluez5-backend-hsphfpd=false \
      -Dvulkan=true \
      -Dv4l2=false \
      -Dexamples=false \
      builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
   system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

end
