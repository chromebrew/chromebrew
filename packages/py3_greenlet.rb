require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version '3.0.3-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '121f47fd65b5c2848a8d76e2a6e3b9eedd3984edce665982b02508da5e981433',
     armv7l: '121f47fd65b5c2848a8d76e2a6e3b9eedd3984edce665982b02508da5e981433',
       i686: 'f820171ae93ed40ac6ed144dec475f074fa5db0517709141a749f485be147d2f',
     x86_64: '89d562600c573954e61e41536f6291916f0a4b5dd31b06fed0991bc51a16c3e4'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_source_build
end
