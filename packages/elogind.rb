require 'package'

class Elogind < Package
  description 'Standalone logind fork'
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
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} _build -Dcgroup-controller=elogind -Dman=false \ 
-Ddefault-hierarchy=legacy -Ddefault-kill-user-processes=false -Dhalt-path=/sbin/halt -Drootlibexecdir=#{CREW_PREFIX}/libexec/elogind -Dreboot-path=/sbin/reboot"
    system 'ninja -v -C _build'
  end
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
