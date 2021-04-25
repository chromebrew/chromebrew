require 'package'

class Pipewire < Package
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipewire.org'
  @_ver = '0.3.26'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://github.com/PipeWire/pipewire/archive/#{@_ver}.tar.gz"
  source_sha256 '05cc9d25de45290c025da5da1b94fc705bddacd93cf3690d0b2988c1ac501ee1'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/pipewire-0.3.26-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7ls/pipewire-0.3.26-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/pipewire-0.3.26-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/pipewire-0.3.26-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd539d5a392ed6bd4189610ea5cdc42c87a1ba238dec635883634f9f962a56a4d',
     armv7l: 'd539d5a392ed6bd4189610ea5cdc42c87a1ba238dec635883634f9f962a56a4d',
       i686: '43bc1175d6f75755fc8fb3abe4b9e473d7ccc3593f1c53f504a2eee7b19b84c2',
     x86_64: '27bdc741fe0b577e3cbfa5ef4f419f23f18cf9a06f04df815249f58dbabe5d28'
  })

  depends_on 'alsa_lib' # R
  depends_on 'alsa_plugins' => :build
  depends_on 'dbus' # R
  depends_on 'eudev' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gsettings_desktop_schemas' -> :build
  depends_on 'gst_plugins_base' # R
  depends_on 'gstreamer' # R
  depends_on 'jack' # R
  depends_on 'libsndfile' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R

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
