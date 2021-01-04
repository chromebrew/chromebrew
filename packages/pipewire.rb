require 'package'

class Pipewire < Package
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipwire.org'
  version '0.3.18'
  compatibility 'all'
  source_url 'https://github.com/PipeWire/pipewire/archive/0.3.18.tar.gz'
  source_sha256 'a7317de8e54f57190a2e2fe5f469ed332b9a12151fade03bf984765a55e5e24b'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.18-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.18-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.18-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '503afbafc6c6add7d84a5ca1d026057f6f67f7d8b27498febf7d887f58d59937',
      armv7l: '503afbafc6c6add7d84a5ca1d026057f6f67f7d8b27498febf7d887f58d59937',
        i686: '485cfec97ba76d9dd3147e5c0dce95a55d189f6a40f15f19f1ed9db9743b75ca',
      x86_64: 'f7ef32d34e699a50cf729ef8d7c633bcc066669fa571140e7a64cc39f828780e',
  })




  depends_on 'gsettings_desktop_schemas'
  depends_on 'alsa_plugins' => :build
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'jack'
  depends_on 'eudev'

  def self.build
    system "meson \
      #{CREW_MESON_OPTIONS} \
      -Dbluez5=false \
      -Dbluez5-backend-native=false \
      -Dbluez5-backend-ofono=false \
      -Dbluez5-backend-hsphfpd=false \
      -Dvulkan=false \
      -Dv4l2=false \
      -Dexamples=false \
      build"
    system "meson configure build"
    system "ninja -C build"
  end

  def self.install
   system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end

end
