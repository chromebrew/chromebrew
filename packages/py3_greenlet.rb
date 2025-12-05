require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a646bfd1173b9cfe8981190c6fa6f4d54637403d3b5408f1d32807d868205f3a',
     armv7l: 'a646bfd1173b9cfe8981190c6fa6f4d54637403d3b5408f1d32807d868205f3a',
       i686: 'e62cdf97fd96b5043fac6b6ecd7b5d12472c06105e71503f17acdf6b19a19705',
     x86_64: '2b7719e9574ad95460105672ba3e4803ad07c54e73fe1cae8264ab7bd45ba2cb'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' # R

  no_source_build
end
