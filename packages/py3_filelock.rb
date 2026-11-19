require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.2.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80e9d8ecf9c977b3c227e3545b9e8c075915845861059946abbf703033e9cc6f',
     armv7l: '80e9d8ecf9c977b3c227e3545b9e8c075915845861059946abbf703033e9cc6f',
       i686: '1f0b02f26cfae63359730166690ed7bf1a45b405d5bc76a84c535ff5e151569e',
     x86_64: 'b643258651fdf59e1357f37fa2c35eabc85dc2c58076c40b64e075b4b3302edd'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
