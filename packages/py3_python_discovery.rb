require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41601bda5fbbb794d6d1a86fbacc6a217034e9f84cc208395423a00b8b41347d',
     armv7l: '41601bda5fbbb794d6d1a86fbacc6a217034e9f84cc208395423a00b8b41347d',
       i686: 'ffdc4738f678972455fb8520c391fef79737b1d3c422476af08eaa3e2ac5ce4f',
     x86_64: 'e41877f9a5909250d5de448731ab0b6f3537829acb27f860b7fcdb85642b528b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
