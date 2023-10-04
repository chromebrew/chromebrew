require 'buildsystems/meson'

class Networkmanager < Meson
  description 'Network connection manager and user applications'
  homepage 'https://wiki.gnome.org/Projects/NetworkManager'
  version '1.44.2'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/archive/#{version}/NetworkManager#{version}.tar.bz2"
  source_sha256 '8dccf93214de0723f7f961f002f9d82428ddaee4604c524fbda883ce4992e660'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/networkmanager/1.44.2_armv7l/networkmanager-1.44.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/networkmanager/1.44.2_armv7l/networkmanager-1.44.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/networkmanager/1.44.2_x86_64/networkmanager-1.44.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '59f9d7dc41ad58396ae07cd39c71b2c232cfac55ce795f57b214c7e6044087b8',
     armv7l: '59f9d7dc41ad58396ae07cd39c71b2c232cfac55ce795f57b214c7e6044087b8',
     x86_64: '0ec3bb100f5e28b62f80272c2fb50d2ad75107370b372f4e6ea9e2af2c28809b'
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

  meson_options "--default-library=both \
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
    -Dqt=false"
end
