require 'package'

class Alien < Package
  description 'This program converts linux packages between the rpm, deb, tgz and slp packages.'
  homepage 'https://sourceforge.net/projects/alien-pkg-convert/'
  version '8.95'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/alien-pkg-convert/release/alien_8.95.tar.xz'
  source_sha256 '37a22587c33810feab323474bdadbf969fda2eb4e720b2ca01b40d82d6f71a17'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alien-8.95-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alien-8.95-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alien-8.95-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alien-8.95-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '81431f3b524332343a63bfc4d81a7d26d699de468d4d1001fa71490d50ecfe7a',
     armv7l: '81431f3b524332343a63bfc4d81a7d26d699de468d4d1001fa71490d50ecfe7a',
       i686: 'de538bab2f24de717daf5acfd25bcfb4b88ec19c77fb35bf5202e82583d8425e',
     x86_64: 'afce6bceff55c145665ce49f8f0c1199b67252eda478312c7d0db042c1fcfde9',
  })

  def self.build
    system 'perl Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
