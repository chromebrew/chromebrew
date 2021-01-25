require 'package'

class Elogind < Package
  description 'Standalone systemd-logind fork'
  homepage 'https://github.com/elogind/elogind'
  version '243.4'
  compatibility 'all'
  source_url 'https://github.com/elogind/elogind/archive/v243.4.tar.gz'
  source_sha256 'f1098745863138e6270ea22e78a39baef9a0356b48246c5a53b34211992dc7db'
  
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
    FileUtils.mv Dir.glob('bin/*'), "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv etc, "#{CREW_DEST_PREFIX}/etc"
    FileUtils.mv Dir.glob("#{ARCH_LIB}/*"), CREW_DEST_LIB_PREFIX
  end
end
