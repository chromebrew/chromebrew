require 'package'

class Pipewire < Package
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipewire.org'
  @_ver = '0.3.29'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://github.com/PipeWire/pipewire/archive/#{@_ver}.tar.gz"
  source_sha256 'b733532d6460fb94d202a8b2104b0a87344e8484e69ccfdf44096dde91c21cf0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.29_armv7l/pipewire-0.3.29-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.29_armv7l/pipewire-0.3.29-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.29_i686/pipewire-0.3.29-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.29_x86_64/pipewire-0.3.29-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4dcdc0d5ea6d83011bef5521c495cde21ae518616bde047e52179a3b95b2a56a',
     armv7l: '4dcdc0d5ea6d83011bef5521c495cde21ae518616bde047e52179a3b95b2a56a',
       i686: '0dbeda58c4e1db7a180ebfb2b7bc3057cc6966927f4d5ee543953b734dfc4510',
     x86_64: '41c64acd73abcd9aa21fb936bf64371b6f82d36cd2a397b8f14f91de0d4c70df'
  })

  depends_on 'alsa_lib' # R
  depends_on 'alsa_plugins' => :build
  depends_on 'dbus' # R
  depends_on 'eudev' # R
  depends_on 'glib' # R
  depends_on 'gsettings_desktop_schemas' => :build
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
