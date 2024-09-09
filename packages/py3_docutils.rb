require 'buildsystems/pip'

class Py3_docutils < Pip
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  version '0.21.2-py3.12'
  license 'BSD-2, GPL-3 and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b1fa9bff0f4feb2692cc90b12935be101ec67a48c8b9589748cfbc49a1ea0690',
     armv7l: 'b1fa9bff0f4feb2692cc90b12935be101ec67a48c8b9589748cfbc49a1ea0690',
       i686: 'b7c21f26cae9887601cfb57af381219a583ba285d93c018763867e15f9c854bc',
     x86_64: '79bdccab23ba746ab68c283acb3d7de3318dcdd4644c84efb058ffca21c69f1f'
  })

  depends_on 'python3' => :build

  no_source_build
end
