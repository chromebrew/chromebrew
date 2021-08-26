require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '8.7'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable/archive/refs/tags/V_8_7_P1.tar.gz'
  source_sha256 '7094e2d9886f07ed7885c4a5d212384259b3b935932920a0eb95eba35a4542a0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.7_armv7l/openssh-8.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.7_armv7l/openssh-8.7-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.7_i686/openssh-8.7-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.7_x86_64/openssh-8.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '773918e9e9fdcbeba4b4240057e0d1946942806e37ae1812c5dbbb37aca8154f',
     armv7l: '773918e9e9fdcbeba4b4240057e0d1946942806e37ae1812c5dbbb37aca8154f',
       i686: '3ec04d72c174ede9ff283c5e0a8f994fba40e714ebc21ed647e4964b1ff8c80c',
     x86_64: '8c04f059c2d1f7683185d795fd87adad1988cd46546ab0c445957c2ed593781c'
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
