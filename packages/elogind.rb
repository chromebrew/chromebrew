require 'package'

class Elogind < Package
  description 'Standalone systemd-logind fork'
  homepage 'https://github.com/elogind/elogind'
  @_ver = '246.10'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/elogind/elogind/archive/v#{@_ver}.tar.gz"
  source_sha256 '9a6285c077f3345c69fc21d1902226966ef6dc6e40d0eba259ee882c5b766eca'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elogind-246.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elogind-246.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elogind-246.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elogind-246.10-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '757fc7dc87b8699b51abdbc3b5b7e7dc505cc3bf1934aabe356d7bfff6712d2d',
     armv7l: '757fc7dc87b8699b51abdbc3b5b7e7dc505cc3bf1934aabe356d7bfff6712d2d',
       i686: '8e1c7f42275654fe1a3010c8631be0b5095f6bdcad3020f5ed4b3dd68289eee7',
     x86_64: '186e7ec40bded8ae9624b8dd3ff90880cd6d0de98016413745d2f672a43cbfa7'
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
  depends_on 'polkit'

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
