require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.0.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '92f4a4264ed3c334dbb1f272b54279893bf9e6438a97a439edb822d5c6e764c7',
     armv7l: '92f4a4264ed3c334dbb1f272b54279893bf9e6438a97a439edb822d5c6e764c7',
       i686: '3c3b0de01617c8c8a9652fe6ed1b63ff830371c73bc5c570805935027d76bf1d',
     x86_64: '59ea53ec98d814bce56f64b074d843cf4ffbca4a3438dc895da3c3b59377340b'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
