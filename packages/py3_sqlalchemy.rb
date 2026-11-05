require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.1.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4fd436d98692a48b26fd2c62d42e6d00965e5e6bc2a190bad00d96b22afb5fbd',
     armv7l: '4fd436d98692a48b26fd2c62d42e6d00965e5e6bc2a190bad00d96b22afb5fbd',
       i686: '013c22007f717db19b825242aaf9f5a35def8f56883dddabe6369dbb0aefefe0',
     x86_64: 'eb3a56d704a6687672239f3338a8fbfa1e171fb1075e9f8afd3b878ce9820eed'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
