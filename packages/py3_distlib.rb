require 'buildsystems/pip'

class Py3_distlib < Pip
  description 'Distlib provides distribution utilities for Python packages.'
  homepage 'https://bitbucket.org/pypa/distlib/'
  version "0.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80335cec406a2d674cd339fca3de2dd452b685100726bc14462ed248e357122c',
     armv7l: '80335cec406a2d674cd339fca3de2dd452b685100726bc14462ed248e357122c',
       i686: 'dbe9189e0fdb24d70a85f4113f6c766edf251a2fa85a393149c31c13fea44435',
     x86_64: 'eb0bf8476b9c6b4927fb2343a97776be6daded1c7e18b734d1106bcc9c6dd19d'
  })

  depends_on 'python3' => :build

  no_source_build
end
