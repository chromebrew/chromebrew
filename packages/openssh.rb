require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '9.0'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag 'V_9_0_P1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.0_armv7l/openssh-9.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.0_armv7l/openssh-9.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.0_i686/openssh-9.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/9.0_x86_64/openssh-9.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1b2b89b564f54e904c099fa8e3ea7c06b583cccfb707847451d43d03f00d309d',
     armv7l: '1b2b89b564f54e904c099fa8e3ea7c06b583cccfb707847451d43d03f00d309d',
       i686: 'a1779dbdb66cfbbb0b1c3757ec0cf1ece7f2f1853ab54e1fcc5f36dcab87040e',
     x86_64: '56e2ccade58561a5f3da1b898015338715cf499a24b906784bf5be4d77382a7a'
  })

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
