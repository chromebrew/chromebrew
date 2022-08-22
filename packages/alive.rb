require 'package'

class Alive < Package
  description 'Automatic login and keep-alive utility for Internet connections.'
  homepage 'https://www.gnu.org/software/alive/'
  version '2.0.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/alive/alive-2.0.3.tar.xz'
  source_sha256 '8bf41150ade07b86a806ce40ce99509713e2abcc92c4182a8d961aa3cf757014'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alive/2.0.3_armv7l/alive-2.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alive/2.0.3_armv7l/alive-2.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alive/2.0.3_i686/alive-2.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alive/2.0.3_x86_64/alive-2.0.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '71b2d2e62c4858eecc2a7d11cc1b767b48587597714de6e6b89b2890c743e026',
     armv7l: '71b2d2e62c4858eecc2a7d11cc1b767b48587597714de6e6b89b2890c743e026',
       i686: '9a06f4e646d7e9c1a0ce43c596c0b32e46024013c0867b7aa5b64c3a431261ea',
     x86_64: 'a123e91cd331380092a1b598e87c4252fa38c71094d17263432c3329c543c904'
  })

  depends_on 'guile'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
