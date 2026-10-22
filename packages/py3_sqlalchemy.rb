require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.1.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56ffbbd30257fd27de7cfc1c59d5f876d46c020bf934f1e9190225a5e78ac898',
     armv7l: '56ffbbd30257fd27de7cfc1c59d5f876d46c020bf934f1e9190225a5e78ac898',
       i686: 'e4cf4b70760a76cb19dc0098d2a96873c93f23abb3ff3e86f486e1febac6a62a',
     x86_64: '7ccb70b070738aadce9470e7aa71eeb1ca2dec143984a455dd98718875374e6f'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
