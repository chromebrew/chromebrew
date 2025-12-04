require 'buildsystems/pip'

class Py3_ebooklib < Pip
  description 'Ebooklib is a Python E-book library for handling books in EPUB2/EPUB3 format.'
  homepage 'https://docs.sourcefabric.org/projects/ebooklib/'
  version "0.20-#{CREW_PY_VER}"
  license 'AGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '834cc71a9b93a49500d6327cc0bb098a2a937ab5148efe94eea2c90aad60c399',
     armv7l: '834cc71a9b93a49500d6327cc0bb098a2a937ab5148efe94eea2c90aad60c399',
       i686: '72593ef451ae90ae757dcea8ab2162bb152610f8e29087647deef6df1c1d5378',
     x86_64: 'b7d0105ce07949b4947feef860730aee314bd0cacecbd86744802c65bb1d6c56'
  })

  depends_on 'py3_lxml' # R
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
