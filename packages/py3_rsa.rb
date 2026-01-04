require 'buildsystems/pip'

class Py3_rsa < Pip
  description 'Pure-Python RSA implementation'
  homepage 'https://stuvel.eu/rsa'
  version "4.9.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4dd25d223bda8d5950a087a664b57d2b7ec0539e68349ab256dc516e8e09a4e1',
     armv7l: '4dd25d223bda8d5950a087a664b57d2b7ec0539e68349ab256dc516e8e09a4e1',
       i686: '682631b8eaa965a05ef8057988bbefd22828992d84725b176e665ae5f9014a09',
     x86_64: '95fc6e372345a9e22ad6f352e838b5d0af6df01412854789a49d4c82b6b30a77'
  })

  depends_on 'python3' => :build

  no_source_build
end
