require 'package'

class Tinycc < Package
  description 'TinyCC (aka TCC) is a small but hyper fast C compiler.'
  homepage 'https://bellard.org/tcc/'
  version '0.9.27'
  source_url 'https://download.savannah.gnu.org/releases/tinycc/tcc-0.9.27.tar.bz2'
  source_sha256 'de23af78fca90ce32dff2dd45b3432b2334740bb9bb7b05bf60fdbfc396ceb9c'

  binary_url ({
  })
  binary_sha256 ({
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
