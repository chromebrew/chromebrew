require 'package'

class Shrinkpdf < Package
  description 'A simple wrapper around Ghostscript to shrink PDFs (as in reduce filesize) under Linux.'
  homepage 'https://github.com/aklomp/shrinkpdf'
  version '1.1'
  license 'BSD-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://raw.githubusercontent.com/aklomp/shrinkpdf/v#{version}/shrinkpdf.sh'
  source_sha256 'bd23c0917741a6a63694bcb99315c4afabdac0d24fef2be896c5be5c7b3aed3c'

  binary_sha256({
    aarch64: '?',
     armv7l: '?',
     x86_64: '?'
  })

  depends_on 'ghostscript'

  def self.install
    system "install -Dm755 shrinkpdf.sh #{CREW_DEST_PREFIX}/bin/shrinkpdf"
  end
end
