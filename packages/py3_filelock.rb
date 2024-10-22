require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.16.1-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf1481ea759a4219be96c8ffcd1131c6e0a5d8dd998ea8a43e305d1768b4dfca',
     armv7l: 'bf1481ea759a4219be96c8ffcd1131c6e0a5d8dd998ea8a43e305d1768b4dfca',
       i686: 'b6a63131803fa6e0fa072c527b6c21f454028d95f374a2105eebfff9b238bc5f',
     x86_64: '1eec59817fac828643c5c4772964f3f7fe70f939084e37c3f366505915586e13'
  })

  depends_on 'python3' => :build

  no_source_build
end
