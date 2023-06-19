require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '9.3'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag 'V_9_3_P1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.3_armv7l/openssh-9.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.3_armv7l/openssh-9.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.3_i686/openssh-9.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.3_x86_64/openssh-9.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1a63e381cdc66ab8a90f5ab09e330c82049ae9c2d9f1214a60bd2f7674d59b30',
     armv7l: '1a63e381cdc66ab8a90f5ab09e330c82049ae9c2d9f1214a60bd2f7674d59b30',
       i686: 'b034291d0bdb5df894bf94c388c091084c74fbec744914377b3525cb533d3b4a',
     x86_64: '13016d5e28942c0c225ba914a23ed4a604d5f55c426cf49f51dd24c5f7e18e92'
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
