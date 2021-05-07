require 'package'

class Pipewire < Package
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipewire.org'
  @_ver = '0.3.27'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://github.com/PipeWire/pipewire/archive/#{@_ver}.tar.gz"
  source_sha256 '657db1b9a29ae17a9f1d9782a45bda2ba5a893fef55e1ca26453e8f7f2d4e64e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.27_armv7l/pipewire-0.3.27-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.27_armv7l/pipewire-0.3.27-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.27_i686/pipewire-0.3.27-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.27_x86_64/pipewire-0.3.27-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '87a66ffe7fe0454081a49ab17bb583f7b58bf529cc9914019540939551c065ea',
     armv7l: '87a66ffe7fe0454081a49ab17bb583f7b58bf529cc9914019540939551c065ea',
       i686: 'c3a2fe495e7c279638c3ec6d3b937259ac609e8d31e8087bd6ff37ba8b2d53dd',
     x86_64: '7f9dd0164d68f19feb219d42996315ed8a6a4c9aa6265bdd83e1293f965a769e'
  })

  depends_on 'alsa_lib' # R
  depends_on 'alsa_plugins' => :build
  depends_on 'dbus' # R
  depends_on 'eudev' # R
  depends_on 'glibc' # R
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
