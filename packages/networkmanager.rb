require 'buildsystems/meson'

class Networkmanager < Meson
  description 'Network connection manager and user applications'
  homepage 'https://wiki.gnome.org/Projects/NetworkManager'
  version '1.48.6'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/NetworkManager/NetworkManager.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94bca001dd896daa5946f91cc614676676736032d642e139db4da3dd32ddc34b',
     armv7l: '94bca001dd896daa5946f91cc614676676736032d642e139db4da3dd32ddc34b',
     x86_64: '24af09176b9f7be2a9f008a95706db02fb9061e177cd0274651e3e6251f8a92b'
  })

  depends_on 'curl' # R
  depends_on 'elogind' # R
  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'jansson' # R
  depends_on 'libndp' # R
  depends_on 'libnewt' # R
  depends_on 'libpsl' # R
  depends_on 'mobile_broadband_provider_info' => :build
  depends_on 'modemmanager' # R
  depends_on 'nss' # R
  depends_on 'readline' # R
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
