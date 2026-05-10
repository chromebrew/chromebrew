require 'buildsystems/pip'

class Py3_olefile < Pip
  description 'Olefile is a Python package to parse, read and write Microsoft OLE2 files.'
  homepage 'https://www.decalage.info/python/olefileio/'
  version "0.47-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9085947cb9c00c3bcb56d5c4b53c3478709f2c8e068faeb0893f88e671862dd1',
     armv7l: '9085947cb9c00c3bcb56d5c4b53c3478709f2c8e068faeb0893f88e671862dd1',
       i686: '8280c9a7aca4b7f1923b1f7a0d7bf83304130840e568f891aebbb56cef4d0daf',
     x86_64: 'e4c777ff873338e26289f30a90ce069550232e85ed721f9bfe6c84d6f21abd41'
  })

  depends_on 'python3' => :logical

  no_source_build
end
