require 'package'

class Grabinfo < Package
  description 'Navigates the /proc filesystem and executes commands in order to gather information about the state of your machine.'
  homepage 'https://sourceforge.net/projects/grabinfo/'
  version '1.71-1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/grabinfo/grabinfo/1.71/grabinfo-1.71.tar.gz'
  source_sha256 '3cf1e56aff10ef182065943a10ab815f2e8bf5ab77716dd97c2e91feb8db4278'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/grabinfo-1.71-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/grabinfo-1.71-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/grabinfo-1.71-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/grabinfo-1.71-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '986b4b357f7b09acaedc81809f1ddbd178d63bbe47a45304d8a8f5b938b243bf',
     armv7l: '986b4b357f7b09acaedc81809f1ddbd178d63bbe47a45304d8a8f5b938b243bf',
       i686: '3a802045aa425c5d78b22a64b0a9a561f741449d5993e6c1dcbbee7ceca1633c',
     x86_64: '7fe45b72e711b264d61cacb333f6f240e965bb409c006c29d15a2cbccf43e52c',
  })

  depends_on 'perl'

  def self.build
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' grabinfo"
    system "sed -i 's,/var/log,#{CREW_PREFIX}/tmp,g' grabinfo"
    system "sed -i 's,/var/log,#{CREW_PREFIX}/tmp,g' grabinfo.1"
    system "sed -i 's,/usr/lib,#{CREW_PREFIX}/lib,g' Makefile"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' Makefile"
    system "sed -i 's,/var/log,#{CREW_PREFIX}/tmp,g' Makefile"
    system "make"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/man/man1"
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/tmp/grabinfo"
    system "cp grabinfo #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    system "cp GrabInfo.pm #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    system "cp -r GrabInfo/ #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    system "cp grabinfo.1 #{CREW_DEST_DIR}#{CREW_PREFIX}/man/man1"
    system "touch #{CREW_DEST_DIR}#{CREW_PREFIX}/tmp/grabinfo/grabinfo.lock"
  end
end
