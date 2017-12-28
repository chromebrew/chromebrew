require 'package'

class Shrinkpdf < Package
  description 'A simple wrapper around Ghostscript to shrink PDFs (as in reduce filesize) under Linux.'
  homepage 'http://alfredklomp.com/programming/shrinkpdf/'
  version '2014'
  source_url 'http://alfredklomp.com/programming/shrinkpdf/index.html'
  source_sha256 'cdc74b28d8ad757fa2cc9d8782031fe2325a17d3f4fd6080c05ca62790e5c690'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ghostscript'

  def self.install
    system 'wget http://alfredklomp.com/programming/shrinkpdf/shrinkpdf.sh'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('shrinkpdf.sh') ) == 'bf313e47e81ce4c088704840554f2f643597db1b3d6937a0af5ed43368b1ccc7'
    system "install -Dm755 shrinkpdf.sh #{CREW_DEST_PREFIX}/bin/shrinkpdf"
  end
end
