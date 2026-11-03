require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.2.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33692d71e34c28f645e9abc6f4f4f51d0be084fe6d4c0c8a98e0d2cd777affb3',
     armv7l: '33692d71e34c28f645e9abc6f4f4f51d0be084fe6d4c0c8a98e0d2cd777affb3',
       i686: 'e611194a4c03632f9c0175b643b4390f3cc6fba953146f9e058495eab5d1df73',
     x86_64: 'e833d038b24bc8852d2a2b41aa7df566338c6690db6c9d23511e17743001add9'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
