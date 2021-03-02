require 'package'

class Elogind < Package
  description 'Standalone systemd-logind fork'
  homepage 'https://github.com/elogind/elogind'
  version '246.9.2-4c20'
  compatibility 'all'
  source_url 'https://github.com/elogind/elogind/archive/4c2042edeb73823c5e7c831c34bea942b9525027.zip'
  source_sha256 '9a6285c077f3345c69fc21d1902226966ef6dc6e40d0eba259ee882c5b766eca'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elogind-246.9.2-4c20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elogind-246.9.2-4c20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elogind-246.9.2-4c20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elogind-246.9.2-4c20-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4978fe7be484892e87a570c6fb8bc4d37c0f75f498178b298f320af25667fb0a',
     armv7l: '4978fe7be484892e87a570c6fb8bc4d37c0f75f498178b298f320af25667fb0a',
       i686: '0b95082c824a6234a2bdd292c741a8c614f1c58afc16375bab9e7091f8f63126',
     x86_64: '9ba1128c658fcb39a903986ad10ed37121f6e0281b081987a8e6fe0a65dc14f4'
  })

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
            -Dsysconfdir=#{CREW_PREFIX}/etc \
            --strip \
            -Dcgroup-controller=elogind \
            -Dman=true \
            -Ddefault-hierarchy=legacy \
            -Ddefault-kill-user-processes=false \
            -Dhalt-path=/sbin/halt \
            -Drootlibdir=#{CREW_PREFIX}/#{ARCH_LIB} \
            -Drootlibexecdir=#{CREW_PREFIX}/libexec/elogind \
            -Drootbindir=#{CREW_PREFIX}/bin \
            -Dreboot-path=/sbin/reboot \
            builddir"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
