require 'package'

class Docutils < Package
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  version '0.15'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/docutils/docutils/0.15/docutils-0.15.tar.gz'
  source_sha256 'c35e87e985f70106f6f97e050f3bed990641e0e104566134b9cd23849a460e96'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docutils-0.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docutils-0.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docutils-0.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docutils-0.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b5e6ebde642f897d08eed30a521daaea456ac179d36a27b002205ab82ddb2a42',
     armv7l: 'b5e6ebde642f897d08eed30a521daaea456ac179d36a27b002205ab82ddb2a42',
       i686: 'e074c6b0893088d27811967dc9f3d9e7321d9a7704f1e468af1564261862cdd6',
     x86_64: '08863068ca607c70717d9a7054ecae077ce8466fe9b06d4e3504b2e7561ee7b7',
  })

  depends_on 'python3'

  def self.install
    system "python3 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
