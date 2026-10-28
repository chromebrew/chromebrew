require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.6.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5afa9717b9b2ee81125fc702bc6d2152409223552135ae388fc6e6889e269bbb',
     armv7l: '5afa9717b9b2ee81125fc702bc6d2152409223552135ae388fc6e6889e269bbb',
       i686: '1852ba2caf9b77424108804d5109d2cf9b4931b7f1f477b7295aa4727361dc22',
     x86_64: '985ba784cde25f62a3a673d1577e15fd72bf1c7b23ebe56c10052824b71cf0b6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
