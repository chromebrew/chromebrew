require 'package'

class Pipewire < Package
  description 'PipeWire is a project that aims to greatly improve handling of audio and video under Linux.'
  homepage 'https://pipewire.org'
  @_ver = '0.3.28'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://github.com/PipeWire/pipewire/archive/#{@_ver}.tar.gz"
  source_sha256 '1d9271e121a5049aef379e9bb7c50524faa6f971e668806637d7b9df1b7cab88'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.28_armv7l/pipewire-0.3.28-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.28_armv7l/pipewire-0.3.28-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.28_i686/pipewire-0.3.28-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pipewire/0.3.28_x86_64/pipewire-0.3.28-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2f4f71d61319ef1882ae5240e093bb0db5518d095ec2de9223388b6118f336c7',
     armv7l: '2f4f71d61319ef1882ae5240e093bb0db5518d095ec2de9223388b6118f336c7',
       i686: 'ac80a8a44ba6c8cfbb3ac497ed9989c08b812f112b2b5da248fa87b0b0c35333',
     x86_64: 'ce9b6af80ef7165dab519f278ea652e74a4aa403f7540b5417bd959aab1adfb6'
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
