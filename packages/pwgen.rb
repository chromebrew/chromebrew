require 'package'

class Pwgen < Package
  description 'Pwgen is a small, GPL\'ed password generator which creates passwords which can be easily memorized by a human.'
  homepage 'https://sourceforge.net/projects/pwgen/'
  version '2.07'
  compatibility 'all'
  source_url 'https://pilotfiber.dl.sourceforge.net/project/pwgen/pwgen/2.07/pwgen-2.07.tar.gz'
  source_sha256 'eb74593f58296c21c71cd07933e070492e9222b79cedf81d1a02ce09c0e11556'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pwgen-2.07-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pwgen-2.07-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pwgen-2.07-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pwgen-2.07-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9e161bac515926d16d09d52802b26c672d1152cfcacb16238ed78808dff5ad32',
     armv7l: '9e161bac515926d16d09d52802b26c672d1152cfcacb16238ed78808dff5ad32',
       i686: 'd6500428a6e57076d155611ce5dd66e1774741877e85e048ad17acf934e28c72',
     x86_64: '8f3a0751bda9fd08f77608ae22a43529844bf3f11f33f4363541cd144f333aa2',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
