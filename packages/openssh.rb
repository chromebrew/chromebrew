require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '9.2'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag 'V_9_2_P1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.2_armv7l/openssh-9.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.2_armv7l/openssh-9.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.2_i686/openssh-9.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.2_x86_64/openssh-9.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b6b52c354cdfbaed0106310c665a3589d12246ff54b6d203eca450026c7dd8bc',
     armv7l: 'b6b52c354cdfbaed0106310c665a3589d12246ff54b6d203eca450026c7dd8bc',
       i686: '44360be3865797524ce9ae1b35903945ec15bbfcbd9f636797c99fa4c8003431',
     x86_64: '989eb709d54b431f481127d60fa492b76bbcc24b8db3af6ad9f1d2b23eff62ff'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

  def self.build
    system 'autoreconf -fiv'
    system 'autoheader'
    # hardening breaks build with "retpolineplt: unknown -z option" error.
    system "./configure #{CREW_OPTIONS} --without-hardening"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
