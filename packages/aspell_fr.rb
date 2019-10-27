require 'package'

class Aspell_fr < Package
  description 'French Aspell Dictionary'
  homepage 'https://ftpmirror.gnu.org/aspell/dict/0index.html'
  version '0.50-3'
  source_url 'https://ftpmirror.gnu.org/aspell/dict/fr/aspell-fr-0.50-3.tar.bz2'
  source_sha256 'f9421047519d2af9a7a466e4336f6e6ea55206b356cd33c8bd18cb626bf2ce91'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'aspell'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
