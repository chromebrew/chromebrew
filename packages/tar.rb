require 'package'

class Tar < Package
  description 'GNU Tar provides the ability to create tar archives, as well as various other kinds of manipulation.'
  homepage 'https://www.gnu.org/software/tar/'
  version '1.34'
  license 'BSD'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/tar/tar-1.34.tar.xz'
  source_sha256 '63bebd26879c5e1eea4352f0d03c991f966aeb3ddeb3c7445c902568d5411d28'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tar/1.34_armv7l/tar-1.34-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tar/1.34_armv7l/tar-1.34-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tar/1.34_i686/tar-1.34-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tar/1.34_x86_64/tar-1.34-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '898fd64b0817f74dac69492bf66f913780e5534e9892f758bae5af438efcbb67',
     armv7l: '898fd64b0817f74dac69492bf66f913780e5534e9892f758bae5af438efcbb67',
       i686: '90df71b982ef410e8565d08da6705cf462d204edf1285dd4e263d2dc3fbcaa4d',
     x86_64: '612413ba98a487c364dc5aeea78ecc772a5447b44b6205a28afbe06ff4ae683c',
  })

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} --with-lzma=xz"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
