require 'package'

class Pipewire < Package
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipewire.org'
  @_ver = '0.3.24'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://github.com/PipeWire/pipewire/archive/#{@_ver}.tar.gz"
  source_sha256 'aeca2b44660c4f36eed29cc9c6ccb093ea2778fd0e4ed7665cdfc40b2a49873f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.24-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.24-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.24-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pipewire-0.3.24-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '008b5f294106edf2a3c02e682a127dc2e89e246e697dc73d642f374aeb241c80',
     armv7l: '008b5f294106edf2a3c02e682a127dc2e89e246e697dc73d642f374aeb241c80',
       i686: '547acc0cc83406d33343111580906e888e665e1343f3a208d1e65990f5f264d7',
     x86_64: '01a5b2a919a8e28ab8bd429c95f91a51897c6e04e68821328f8ee56055d75657'
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

  def self.patch
    # As per https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/833
    system "sed -i 's/ifdef __FreeBSD__/if defined(__FreeBSD__) || defined(__linux__)/g' src/pipewire/impl-core.c"
  end

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
