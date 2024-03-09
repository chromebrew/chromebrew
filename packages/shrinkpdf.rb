require 'package'

class Shrinkpdf < Package
  description 'A simple wrapper around Ghostscript to shrink PDFs (as in reduce filesize) under Linux.'
  homepage 'http://alfredklomp.com/programming/shrinkpdf/'
  version '2014'
  license 'BSD-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'http://alfredklomp.com/programming/shrinkpdf/index.html'
  source_sha256 'cdc74b28d8ad757fa2cc9d8782031fe2325a17d3f4fd6080c05ca62790e5c690'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '19c53e4be836957a64613eb60e329506cfafde2891c54155b99ba16de0855ba6',
     armv7l: '19c53e4be836957a64613eb60e329506cfafde2891c54155b99ba16de0855ba6',
     x86_64: '92e7bddf8ead1324927547c1591e7f6192c2b195a8137a3365597c08d802f950'
  })

  depends_on 'ghostscript'

  def self.install
    system 'curl -#LO http://alfredklomp.com/programming/shrinkpdf/shrinkpdf.sh'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest(File.read('shrinkpdf.sh')) == 'bf313e47e81ce4c088704840554f2f643597db1b3d6937a0af5ed43368b1ccc7'
    system "install -Dm755 shrinkpdf.sh #{CREW_DEST_PREFIX}/bin/shrinkpdf"
  end
end
