require 'buildsystems/pip'

class Py3_requests < Pip
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://docs.python-requests.org/'
  version "2.34.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0aaf573b9b5cdb8162c9b4de3c2bea374f8d8c00341f1967f28fdfa1c62f8926',
     armv7l: '0aaf573b9b5cdb8162c9b4de3c2bea374f8d8c00341f1967f28fdfa1c62f8926',
       i686: '87e2f0a635a0e1a2bb4f2efe30e18fa4a4ce9d030a9027e3ed3f7cbabd3e92a3',
     x86_64: '424cb00fc52aa100d9d1b3555b83c86bba4c71cef0fd113d1276d5e3c2e25b24'
  })

  depends_on 'py3_charset_normalizer'
  depends_on 'py3_idna'
  depends_on 'py3_urllib3'
  depends_on 'python3' => :logical

  no_source_build
end
