require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '9.3p2'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag 'V_9_3_P2'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.3p2_i686/openssh-9.3p2-chromeos-i686.tar.zst',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.3p2_armv7l/openssh-9.3p2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.3p2_armv7l/openssh-9.3p2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.3p2_x86_64/openssh-9.3p2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
       i686: '6ef7930647d75f8df8146c252f08ea3a588c9b5ec30459374f7b6ad69ab57b82',
    aarch64: 'd270fd8923e239bf8122fd026d7469830893043c19afc538ce1b415c02aa3e12',
     armv7l: 'd270fd8923e239bf8122fd026d7469830893043c19afc538ce1b415c02aa3e12',
     x86_64: '14121876580f0c5dfcc5ca3a4d8db27cf86f734b22ea0edd9ca9c5daaab8b8c6'
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
