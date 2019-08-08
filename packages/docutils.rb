require 'package'

class Docutils < Package
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  version '0.15'
  source_url 'https://prdownloads.sourceforge.net/project/docutils/docutils/0.15/docutils-0.15.tar.gz'
  source_sha256 'c35e87e985f70106f6f97e050f3bed990641e0e104566134b9cd23849a460e96'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'

  def self.install
    system "python3 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
