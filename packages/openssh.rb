require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '8.6'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable/archive/refs/tags/V_8_6_P1.tar.gz'
  source_sha256 'b641e88a61b58d60f87b1c0e38805eb5b1206810cab71b1f2966faa87938593b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.6_armv7l/openssh-8.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.6_armv7l/openssh-8.6-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.6_i686/openssh-8.6-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.6_x86_64/openssh-8.6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '13c4fc76c595404df4a6b53be4e35580bda59937841668c73b4b2f871d559350',
     armv7l: '13c4fc76c595404df4a6b53be4e35580bda59937841668c73b4b2f871d559350',
       i686: 'e64aba77b0115d4cd3248961215b2ae638548d40f6b31707202de42792895f11',
     x86_64: '4900147acf20bfcf9dd27654563a2aeefed7b63e12eb7a9fa96992194ce07f24'
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
