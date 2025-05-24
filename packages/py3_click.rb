require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.2.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '62a3166e0192c0055ea995301385f3a2d1ce2cd12befaf8a257226c02ec1e3a0',
     armv7l: '62a3166e0192c0055ea995301385f3a2d1ce2cd12befaf8a257226c02ec1e3a0',
       i686: 'df3c72ee468f03a6876efc0aeb613e5b49bef9661c11f8ac673f74dc04b1ef6f',
     x86_64: '3960f30e0e9d498706a0836b8c5e40bae69c6d10003488b0bcd4b110da099758'
  })

  depends_on 'python3' => :build

  no_source_build
end
