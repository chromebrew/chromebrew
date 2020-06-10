require 'package'

class Unshield < Package
  description 'Tool and library to extract CAB files from InstallShield installers.'
  homepage 'https://github.com/twogood/unshield'
  version '1.4.2'
  compatibility 'all'
  source_url 'https://github.com/twogood/unshield/archive/1.4.2.tar.gz'
  source_sha256 '5dd4ea0c7e97ad8e3677ff3a254b116df08a5d041c2df8859aad5c4f88d1f774'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/unshield-1.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/unshield-1.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/unshield-1.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/unshield-1.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c8e532b79f02553de261074d813e908288ba65c55787f83cda72d3af508e6a2b',
     armv7l: 'c8e532b79f02553de261074d813e908288ba65c55787f83cda72d3af508e6a2b',
       i686: '7cfcf019406bdaa22ae42431228f1529b886a3831021cc8eb1df4a2704ba6ca8',
     x86_64: '15626e07093863254c8b3c1c264fa110416fbbe13952876ec2005ef47c46a366',
  })

  def self.build
    system 'cmake .'
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.cp Dir.glob('man/*'), "#{CREW_DEST_MAN_PREFIX}/man1"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
