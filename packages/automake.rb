require 'package'

class Automake < Package
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'https://www.gnu.org/software/automake/'
  version '1.16.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/automake/automake-1.16.4.tar.xz'
  source_sha256 '80facc09885a57e6d49d06972c0ae1089c5fa8f4d4c7cfe5baea58e5085f136d'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/automake/1.16.4_armv7l/automake-1.16.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/automake/1.16.4_armv7l/automake-1.16.4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/automake/1.16.4_i686/automake-1.16.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/automake/1.16.4_x86_64/automake-1.16.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a133dc9e23fc43034e33cb1c6010234f5b58c2475c86a94fdbec752cca91dd34',
     armv7l: 'a133dc9e23fc43034e33cb1c6010234f5b58c2475c86a94fdbec752cca91dd34',
       i686: '649543caf0dabcd38a0d9e5ddbef2ce1fbc8fdb1dc46a3ac70af2c4a13ed92df',
     x86_64: 'b06eab060f18d152a496e89c8ebaae8641ab56d02838d2ca4d6e90a6882b8311',
  })

  depends_on 'autoconf'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
