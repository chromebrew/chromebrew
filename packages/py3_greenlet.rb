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
    aarch64: '1693bb698b6c01b12d2a00d2cc9838fb54db25fb0231acf91eec818ac7127d71',
     armv7l: '1693bb698b6c01b12d2a00d2cc9838fb54db25fb0231acf91eec818ac7127d71',
       i686: 'e1a37fc5bdfd541b9accd7ceb15ccec9d80218375888d3c12e2e96b9bc529aba',
     x86_64: '7c411b8b680c7a0be0ba87bb381137583df9e17b28a855059f088e20973fd4ca'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' # R

  no_source_build
end
