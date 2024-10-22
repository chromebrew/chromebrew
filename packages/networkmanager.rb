require 'buildsystems/meson'

class Networkmanager < Meson
  description 'Network connection manager and user applications'
  homepage 'https://wiki.gnome.org/Projects/NetworkManager'
  version '1.50.0'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/NetworkManager/NetworkManager.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '215e925f063f9419d432ea7193cdae46bc48f26df0160e710c7a523c2da0ae03',
     armv7l: '215e925f063f9419d432ea7193cdae46bc48f26df0160e710c7a523c2da0ae03',
     x86_64: '8c49bebd77de48fafd9d92ebf992332c69b51124ee7c85908ed842e40525c398'
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
