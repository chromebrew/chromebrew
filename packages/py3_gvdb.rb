require 'buildsystems/pip'

class Py3_gvdb < Pip
  description 'Python client for GVDB distributed vector database'
  homepage 'https://github.com/JonathanBerhe/gvdb'
  version "0.30.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a428a756a08717067615c89d3be4049ccfcdbbfefab79b20b06c7df02a05b4f6',
     armv7l: 'a428a756a08717067615c89d3be4049ccfcdbbfefab79b20b06c7df02a05b4f6',
       i686: 'fc801c101c6d32e4eccf8db7e2d950394b7aadf8a90d8860969a52b76b34a858',
     x86_64: '2a85c56db4055f641953d40c894bb1e86de8cb838fd68192d1ce19a1f6a93547'
  })

  depends_on 'python3' => :logical

  no_source_build
end
