require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '8.8'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable/archive/refs/tags/V_8_8_P1.tar.gz'
  source_sha256 'a944effea9597a36c80a6c71aa520bf6fbef7b6bcefbb648dc39d0ed788c90c8'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.8_i686/openssh-8.8-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.8_armv7l/openssh-8.8-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.8_armv7l/openssh-8.8-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.8_x86_64/openssh-8.8-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: '7f584f07449817a69d2780cca72aabae6bdf383b18aa724b710fa7043af53161',
    aarch64: '926ed75ad7a0d374de9f28db3233b34a6e0650cab4e55297858e386286c6df68',
     armv7l: '926ed75ad7a0d374de9f28db3233b34a6e0650cab4e55297858e386286c6df68',
     x86_64: 'd734097f18ce48e634a6300574053e2cb4b904a572264ca6d73beb3a5740bfce'
  })

  def self.build
    system 'autoreconf -fiv'
    system 'autoheader'
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
