require 'package'

class Pipewire < Package
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipewire.org'
  @_ver = '0.3.25'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://github.com/PipeWire/pipewire/archive/#{@_ver}.tar.gz"
  source_sha256 'fb6d5a0cbde621659ffd67622f19744dd6c8da8745b060cb1951c3d2045e5166'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/pipewire-0.3.25-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/pipewire-0.3.25-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/pipewire-0.3.25-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/pipewire-0.3.25-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '90d11afcba0ffd2ce109f5745e4eab64de5088e66d98c5086392d5455f933e22',
     armv7l: '90d11afcba0ffd2ce109f5745e4eab64de5088e66d98c5086392d5455f933e22',
       i686: '45cc47b0b504b2ac20718cd3ba6fb754a87465579f756bb091b7b288c606dc8f',
     x86_64: '17f59cb128de6a9d580631c21b5b94314abdc653adfb5ff59e7b24d4f406e22b'
  })

  depends_on 'alsa_lib'
  depends_on 'alsa_plugins' => :build
  depends_on 'dbus'
  depends_on 'eudev'
  depends_on 'glib'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'jack' => :build
  depends_on 'libsndfile'
  depends_on 'vulkan_headers' => :build

  def self.build
    system "meson \
      #{CREW_MESON_OPTIONS} \
      -Dbluez5-backend-hsphfpd=disabled \
      -Dbluez5-backend-ofono=disabled \
      -Dbluez5=disabled \
      -Dexamples=disabled \
      -Dudevrulesdir=#{CREW_PREFIX}/etc/udev/rules.d \
      -Dv4l2=disabled \
      -Dvolume=auto \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
