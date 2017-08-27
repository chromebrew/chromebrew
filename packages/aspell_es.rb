require 'package'

class Aspell_es < Package
  description 'Spanish Aspell Dictionary'
  homepage 'ftp://ftp.gnu.org/gnu/aspell/dict/0index.html'
  version '1.11-2-1'
  source_url 'ftp://ftp.gnu.org/gnu/aspell/dict/es/aspell6-es-1.11-2.tar.bz2'
  source_sha256 'ad367fa1e7069c72eb7ae37e4d39c30a44d32a6aa73cedccbd0d06a69018afcc'

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
