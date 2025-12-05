require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.2.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2917e9994ec197ab1bfc272d700b3a56457130deeb58aaeaf8f21a19433e5f7e',
     armv7l: '2917e9994ec197ab1bfc272d700b3a56457130deeb58aaeaf8f21a19433e5f7e',
       i686: '532549ca46aea007987483f1af7169459ac93d88b586f1ba2eee451739b3f39d',
     x86_64: '3997539c3c52085a87dd3bcb6a2002166e68ff10ab025d023e3e3f1565134540'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' # R

  no_source_build
end
