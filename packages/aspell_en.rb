require 'package'

class Aspell_en < Package
  description 'English Aspell Dictionary'
  homepage 'ftp://ftp.gnu.org/gnu/aspell/dict/0index.html'
  version '2017.08.24-0'
  source_url 'https://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-2017.08.24-0.tar.bz2'
  source_sha256 '09b562b02195e7facd31d65241050be7ac6f78654128ab41650511bf42dd5b7c'

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
