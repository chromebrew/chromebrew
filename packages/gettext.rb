require 'package'

class Gettext < Package
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version '0.20.1'
  source_url 'https://ftpmirror.gnu.org/gnu/gettext/gettext-0.20.1.tar.xz'
  source_sha256 '53f02fbbec9e798b0faaf7c73272f83608e835c6288dd58be6c9bb54624a3800'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gettext-0.20.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gettext-0.20.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gettext-0.20.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gettext-0.20.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ec3dd9e2671709b47d146e60202f3a40f976e9c339670f1b86de65299efc3817',
     armv7l: 'ec3dd9e2671709b47d146e60202f3a40f976e9c339670f1b86de65299efc3817',
       i686: '52c114e0e62e8aa8a90049f9ecb2086c1249ec442e61a71256b7be86b852b3c7',
     x86_64: 'ee02e72b46bfaa4b7ddd4138466d5217564362a28f582f8d4042b747811c72ac',
  })

  depends_on 'ncurses'
  depends_on 'libxml2'
  depends_on 'icu4c'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static',
           '--enable-shared',
           '--with-pic'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
