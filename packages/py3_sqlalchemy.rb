require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb153652b8e66be3ec9e8eed44471e7779214eb68cf5ca999c89901632e6b1b4',
     armv7l: 'bb153652b8e66be3ec9e8eed44471e7779214eb68cf5ca999c89901632e6b1b4',
       i686: '5f9dbe07217b02cd7ca7e032f1869c8fc721a9a2066543025ed81d3911189677',
     x86_64: 'e18c6a877a8bac4d375a3c6903430c5435a8969f30566ffe4ac5f33747014f5a'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
