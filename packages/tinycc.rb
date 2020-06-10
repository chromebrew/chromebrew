require 'package'

class Tinycc < Package
  description 'TinyCC (aka TCC) is a small but hyper fast C compiler.'
  homepage 'https://bellard.org/tcc/'
  version '0.9.27'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/tinycc/tcc-0.9.27.tar.bz2'
  source_sha256 'de23af78fca90ce32dff2dd45b3432b2334740bb9bb7b05bf60fdbfc396ceb9c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tinycc-0.9.27-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tinycc-0.9.27-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tinycc-0.9.27-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tinycc-0.9.27-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '029ba25378599e4fe2f4b17d1106f33dc0638fba4a993053eb75de8790a1fafc',
     armv7l: '029ba25378599e4fe2f4b17d1106f33dc0638fba4a993053eb75de8790a1fafc',
       i686: 'b403d10c7ee490f1769fef31a83cb75a0dbb26befc75a25fd290e796bdd45798',
     x86_64: 'cff32a0b7312e376565d3b380e8d933c6e979caa940e64bc12872f6e2673c6be',
  })

  def self.patch
    system 'sed -i "/LD_LIBRARY_PATH/s,\$(CURDIR)/\$(TOP),\${LD_LIBRARY_PATH}:&," Makefile'
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' texi2pod.pl"
    system "sed -i 's,\$(tccdir)/include,\$(tccdir)/tcc/include,g' Makefile"
  end

  def self.build
    system './configure',
           '--disable-static',
           "--prefix=#{CREW_PREFIX}",
           "--tccdir=#{CREW_LIB_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
