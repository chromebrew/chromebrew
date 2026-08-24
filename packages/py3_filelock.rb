require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.32.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4948ddbcc098dc30cd9502cec465c82eea42a7e3af6050e7a4723a01494b4625',
     armv7l: '4948ddbcc098dc30cd9502cec465c82eea42a7e3af6050e7a4723a01494b4625',
       i686: 'd7e533e121307e548a01875ae44e1d7488cee282cb9a3ca3e0c76211f45dd82e',
     x86_64: '1aa8af811c5db078ae5ee405e2008cdfcbf1887cf2b9c7c73130e96d19208a78'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
