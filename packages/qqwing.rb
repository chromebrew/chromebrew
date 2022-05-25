require 'package'

class Qqwing < Package
  description 'QQwing is a Sudoku puzzle generator and solver.'
  homepage 'https://qqwing.com/'
  version '1.3.4'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://qqwing.com/qqwing-1.3.4.tar.gz'
  source_sha256 '1753736c31feea0085f5cfac33143743204f8a7e66b81ccd17e249ecafba802f'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qqwing/1.3.4_armv7l/qqwing-1.3.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qqwing/1.3.4_armv7l/qqwing-1.3.4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qqwing/1.3.4_i686/qqwing-1.3.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qqwing/1.3.4_x86_64/qqwing-1.3.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b06f588f35e0e02728cc058ed736a97653c61b0a7dd93f151e301ca2e03bf0a3',
     armv7l: 'b06f588f35e0e02728cc058ed736a97653c61b0a7dd93f151e301ca2e03bf0a3',
       i686: '44111882030a083db1f5f4062124092f69cc2b67094a57c6266f7cd0d5a24c8b',
     x86_64: '2272662e36f739b18a3a24c33e3213cb6a5fbe34b92049154f831f0407f58f21'
  })

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
            ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
