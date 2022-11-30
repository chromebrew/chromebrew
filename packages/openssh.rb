require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '9.1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag 'V_9_1_P1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.1_armv7l/openssh-9.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.1_armv7l/openssh-9.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.1_i686/openssh-9.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.1_x86_64/openssh-9.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4a16590d6708883779e99ed0b53a59a0fda3ebcc3f3528c3a8198496c8868d7b',
     armv7l: '4a16590d6708883779e99ed0b53a59a0fda3ebcc3f3528c3a8198496c8868d7b',
       i686: '9fdbb5717755a3a3a2400c4a4d3f7d0de65910a4a70f855cd8554075665f2ede',
     x86_64: '37e07e2b07840fd71ea6fa75c2fb91f299bf5f827371c0f5f0fc52908988c6ba'
  })

  depends_on 'gcc' # R
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
