require 'package'

class Elogind < Package
  description 'Standalone logind fork'
  homepage 'https://github.com/elogind/elogind'
  version '243.4'
  compatibility 'all'
  source_url 'https://github.com/elogind/elogind/archive/v243.4.tar.gz'
  source_sha256 'f1098745863138e6270ea22e78a39baef9a0356b48246c5a53b34211992dc7db'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elogind-243.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elogind-243.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elogind-243.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elogind-243.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cb9cee0ff417657040c5c02ebe618eaf972e5cb374de641db7e66e8754673fc3',
     armv7l: 'cb9cee0ff417657040c5c02ebe618eaf972e5cb374de641db7e66e8754673fc3',
       i686: '9dbcdc416612a3cc32d71c8120b3c38d6d37b8f75011b4a8cfe04003fe2eb737',
     x86_64: 'e76b69346288beef9a595b90b9f7dd30424339b9c4e906e928ff4bd8cb5f82fa',
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
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} -Dcgroup-controller=elogind \
-Dman=false -Ddefault-hierarchy=legacy -Ddefault-kill-user-processes=false -Dhalt-path=/sbin/halt \
-Drootlibexecdir=#{CREW_PREFIX}/libexec/elogind -Dreboot-path=/sbin/reboot _build"
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
