require 'package'

class Pagein < Package
  description 'Pagein is a tool that forces pages that are in swap to be paged in back to memory.'
  homepage 'http://kernel.ubuntu.com/~cking/pagein/'
  version '0.00.05'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/pagein/pagein-0.00.05.tar.gz'
  source_sha256 '3f81409f6227887212083c585abf5143a082dde2bbcab1d2ae8c74b6d294e8b3'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'make',
      "BINDIR=#{CREW_PREFIX}/bin",
      "MANDIR=#{CREW_PREFIX}/share/man/man1"
  end

  def self.install
    system 'make',
      "DESTDIR=#{CREW_DEST_DIR}",
      "BINDIR=#{CREW_PREFIX}/bin",
      "MANDIR=#{CREW_PREFIX}/share/man/man1",
      'install'
  end
end
