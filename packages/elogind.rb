require 'package'

class Elogind < Package
  description 'Standalone systemd-logind fork'
  homepage 'https://github.com/elogind/elogind'
  version '246.9.2'
  compatibility 'all'
  source_url 'https://github.com/elogind/elogind/archive/v246.9.2.tar.gz'
  source_sha256 'dd2fcf22a89a078cad22e633d2f14a4cc9f4a9c8bae25c0e39fc4aec3e273bc9'
  
  depends_on 'eudev'
  depends_on 'libcap'
  depends_on 'libseccomp'
  depends_on 'linux_pam' # For _pam_macros.h
  depends_on 'dbus'
  depends_on 'docbook_xsl'
  depends_on 'gperf'
  depends_on 'libxslt'
  depends_on 'shadow'
  depends_on 'glib'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
            -Drootprefix=#{CREW_PREFIX} \
            --strip \
            -Dcgroup-controller=elogind \
            -Dman=false \
            -Ddefault-hierarchy=legacy \
            -Ddefault-kill-user-processes=false \
            -Dhalt-path=/sbin/halt \
            -Drootlibdir=#{CREW_PREFIX}/#{ARCH_LIB} \
            -Drootlibexecdir=#{CREW_PREFIX}/libexec/elogind \
            -Drootbindir=#{CREW_PREFIX}/bin \
            -Dreboot-path=/sbin/reboot \
            builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
