require 'package'

class Networkmanager < Package
  description 'Network connection manager and user applications'
  homepage 'https://wiki.gnome.org/Projects/NetworkManager'
  version '1.42.2'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url "https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/archive/#{version}/NetworkManager#{version}.tar.bz2"
  source_sha256 '939a27acb0520efc4af3bb7a7dac1e85c34a4b8bbec2f59e2247baf93ac81403'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/networkmanager/1.42.2_armv7l/networkmanager-1.42.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/networkmanager/1.42.2_armv7l/networkmanager-1.42.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/networkmanager/1.42.2_x86_64/networkmanager-1.42.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cbabb7283021aca5027e28dc36e957464c14ae7496eb098bb4a6fe0a43712f9c',
     armv7l: 'cbabb7283021aca5027e28dc36e957464c14ae7496eb098bb4a6fe0a43712f9c',
     x86_64: '5a48bb9db96022e23cbdb2e76e20a7c009c3700d7cfa208552b3aec2e1b62259'
  })

  depends_on 'gobject_introspection'
  depends_on 'gtk_doc'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'modemmanager'
  depends_on 'libndp'
  depends_on 'jansson'
  depends_on 'nss'
  depends_on 'vala'
  depends_on 'elogind'
  depends_on 'libnewt'
  depends_on 'mobile_broadband_provider_info'
  # depends_on 'ccache' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      --default-library=both \
      -Ddbus_conf_dir=#{CREW_PREFIX}/share/dbus-1/system.d \
      -Dsystem_ca_path=#{CREW_PREFIX}/etc/ssl/certs \
      -Dpolkit_agent_helper_1=#{CREW_LIB_PREFIX}/polkit-1/polkit-agent-helper-1 \
      -Dsession_tracking_consolekit=false \
      -Dsession_tracking=elogind \
      -Dsuspend_resume=elogind \
      -Dsystemdsystemunitdir=no \
      -Dsystemd_journal=false \
      -Dmodify_system=true \
      -Dppp=false \
      -Dselinux=false \
      -Diwd=false \
      -Dteamdctl=false \
      -Dnm_cloud_setup=true \
      -Dbluez5_dun=false \
      -Dlibaudit=no \
      -Debpf=true \
      -Dwifi=true \
      -Dwext=true \
      -Dconfig_plugins_default=keyfile \
      -Dnetconfig=no \
      -Dconfig_dns_rc_manager_default=symlink \
      -Ddhcpcd=no \
      -Dvapi=true \
      -Ddocs=false \
      -Dmore_asserts=no \
      -Dmore_logging=false \
      -Dqt=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir -k 0 && ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
