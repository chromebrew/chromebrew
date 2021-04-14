require 'package'

class Networkmanager < Package
  description 'Network connection manager and user applications'
  homepage 'https://wiki.gnome.org/Projects/NetworkManager'
  @_ver = '1.30.2'
  version @_ver
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/archive/#{@_ver}/NetworkManager#{@_ver}.tar.bz2"
  source_sha256 '9fab930be75a2dc4fcfdacdaf9a870580d2969b64aec019dbfc63f4cab491485'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/networkmanager-1.30.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/networkmanager-1.30.2-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/networkmanager-1.30.2-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/networkmanager-1.30.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '69bf115544cf9735cbbddb8b24d3b10991b3ee430856f8d8ac36b26e4e192f13',
     armv7l: '69bf115544cf9735cbbddb8b24d3b10991b3ee430856f8d8ac36b26e4e192f13',
       i686: '11c10ff9926abbe5ec47a0015d4922d7d33216dd7b2afd3777fca4d43f966c15',
     x86_64: 'b0be77ef463fe109b9b55bfe39997a1611f3243fcf3451da370e358088e8c943'
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
  depends_on 'ccache' => :build

  def self.patch
    # Patch fixes meson dependency race condition
    # from https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/675#note_824519
    @order_patch = <<~ORDER_PATCH_EOF
      diff --git i/clients/tui/newt/meson.build w/clients/tui/newt/meson.build
      index 0c89c0f68155..cbe9d5544995 100644
      --- i/clients/tui/newt/meson.build
      +++ w/clients/tui/newt/meson.build
      @@ -26,6 +26,7 @@ libnmt_newt = static_library(
         ),
         dependencies: [
           libnm_nm_default_dep,
      +    libnm_dep,
           newt_dep,
         ],
         c_args: [
    ORDER_PATCH_EOF
    IO.write('order.patch', @order_patch)
    # This should not be needed in versions newer than 1.30.0 as it is patched
    # in the main branch.
    system 'patch -p1 -i order.patch' unless Gem::Version.new(@_ver) > Gem::Version.new('1.30.0')
    case ARCH
    when 'i686'
      # Older kernel headers break wifi usage on kernel 3.18, so
      # since we disable wifi, just patch around this missing define.
      system "sed -i 's/NL80211_STA_INFO_BEACON_SIGNAL_AVG/NL80211_STA_INFO_SIGNAL_AVG/g' src/core/platform/wifi/nm-wifi-utils-nl80211.c"
      # Add in other missing defines as needed.
      @kernel_missing = <<~KERNEL_MISSING_EOF
        enum {
        IFLA_BR_AGEING_TIME,
        IFLA_BR_STP_STATE,
        IFLA_BR_PRIORITY,
        IFLA_BR_VLAN_FILTERING,
        IFLA_BR_VLAN_PROTOCOL,
        IFLA_BR_GROUP_FWD_MASK,
        IFLA_BR_ROOT_ID,
        IFLA_BR_BRIDGE_ID,
        IFLA_BR_ROOT_PORT,
        IFLA_BR_ROOT_PATH_COST,
        IFLA_BR_TOPOLOGY_CHANGE,
        IFLA_BR_TOPOLOGY_CHANGE_DETECTED,
        IFLA_BR_HELLO_TIMER,
        IFLA_BR_TCN_TIMER,
        IFLA_BR_TOPOLOGY_CHANGE_TIMER,
        IFLA_BR_GC_TIMER,
        IFLA_BR_GROUP_ADDR,
        IFLA_BR_FDB_FLUSH,
        IFLA_BR_MCAST_ROUTER,
        IFLA_BR_MCAST_SNOOPING,
        IFLA_BR_MCAST_QUERY_USE_IFADDR,
        IFLA_BR_MCAST_QUERIER,
        IFLA_BR_MCAST_HASH_ELASTICITY,
        IFLA_BR_MCAST_HASH_MAX,
        IFLA_BR_MCAST_LAST_MEMBER_CNT,
        IFLA_BR_MCAST_STARTUP_QUERY_CNT,
        IFLA_BR_MCAST_LAST_MEMBER_INTVL,
        IFLA_BR_MCAST_MEMBERSHIP_INTVL,
        IFLA_BR_MCAST_QUERIER_INTVL,
        IFLA_BR_MCAST_QUERY_INTVL,
        IFLA_BR_MCAST_QUERY_RESPONSE_INTVL,
        IFLA_BR_MCAST_STARTUP_QUERY_INTVL,
        IFLA_BR_NF_CALL_IPTABLES,
        IFLA_BR_NF_CALL_IP6TABLES,
        IFLA_BR_NF_CALL_ARPTABLES,
        IFLA_BR_VLAN_DEFAULT_PVID,
        IFLA_BR_PAD,
        IFLA_BR_VLAN_STATS_ENABLED,
        IFLA_BR_MCAST_STATS_ENABLED,
        IFLA_BR_MCAST_IGMP_VERSION,
        IFLA_BR_MCAST_MLD_VERSION,
        IFLA_BR_VLAN_STATS_PER_PORT,
        };
      KERNEL_MISSING_EOF
      IO.write('kernel_missing_defs.txt', @kernel_missing)
      system "sed -i '/nm-udev-utils.h/ r kernel_missing_defs.txt' src/core/platform/nm-linux-platform.c"
    end
  end

  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    @ebpf = 'true'
    @wifi = 'true'
    @wext = 'true'
  when 'i686'
    @ebpf = 'false'
    @wifi = 'false'
    @wext = 'false'
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
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
      -Debpf=#{@ebpf} \
      -Dwifi=#{@wifi} \
      -Dwext=#{@wifi} \
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
