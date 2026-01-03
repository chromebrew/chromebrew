require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.20.2-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '198d235b60c191ff4d4c7e9e8ea8205188b6f5d63161a2282f21e098afac52ad',
     armv7l: '198d235b60c191ff4d4c7e9e8ea8205188b6f5d63161a2282f21e098afac52ad',
       i686: '1ed762438a26a4f267d0dc4fb6f1f219ed746824d14546a130393fee124db932',
     x86_64: '2700f73909967c5a50fd60239e1810f1ca300b30a2e5a5678338426d9bdcb5b8'
  })

  depends_on 'python3' => :build

  no_source_build
end
