require 'buildsystems/meson'

class Networkmanager < Meson
  description 'Network connection manager and user applications'
  homepage 'https://wiki.gnome.org/Projects/NetworkManager'
  version '1.46.0'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/NetworkManager/NetworkManager.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59f9d7dc41ad58396ae07cd39c71b2c232cfac55ce795f57b214c7e6044087b8',
     armv7l: '59f9d7dc41ad58396ae07cd39c71b2c232cfac55ce795f57b214c7e6044087b8',
     x86_64: '0ec3bb100f5e28b62f80272c2fb50d2ad75107370b372f4e6ea9e2af2c28809b'
  })

  depends_on 'elogind' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'jansson' => :build
  depends_on 'libndp' => :build
  depends_on 'libnewt' => :build
  depends_on 'mobile_broadband_provider_info' => :build
  depends_on 'modemmanager' => :build
  depends_on 'nss' => :build
  depends_on 'vala' => :build

  gnome

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
