require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.35-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f664e6338199588e76d2b73e1f06f13bd60191098aa560ba8bc0d38a718d194',
     armv7l: '4f664e6338199588e76d2b73e1f06f13bd60191098aa560ba8bc0d38a718d194',
       i686: '124f2b3e57cffcceb4fc9535c338f1defa3cfb16006aa8fbb998fadca912c058',
     x86_64: '63947436315ecf3cf45717a3147bed316273cf7bab09251d9cdb67a28bc9a7ec'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  no_source_build
end
