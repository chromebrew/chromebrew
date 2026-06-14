require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.29.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9340852f4703f06b35bd99e9904c243037abf5231201c3b6086897e8b5b4d72f',
     armv7l: '9340852f4703f06b35bd99e9904c243037abf5231201c3b6086897e8b5b4d72f',
       i686: 'ad20fc4134bc0f3ccd9366f9a9b83a79254c9fe6bb5aad999b06b0126a784a6f',
     x86_64: '2751583296367eef67d750cebd0b40ff5450b73e5a35a39f0dd15e71210094ec'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
