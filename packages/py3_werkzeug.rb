require 'buildsystems/pip'

class Py3_werkzeug < Pip
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  version "3.1.3-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54e137e09fb4b56971dd47521d8ae48e7a393eaa3a34049dcafa7c93d626e104',
     armv7l: '54e137e09fb4b56971dd47521d8ae48e7a393eaa3a34049dcafa7c93d626e104',
       i686: '7cac09625ac15ec99f69cee8ca5bd8d0c57cc5d8cbb35f27f111c6821bf90ef0',
     x86_64: '73ef75e6f6d7c9a6853775eb6d35810ed91c398cdedab2b74c3365167fa36c8f'
  })

  depends_on 'python3' => :build

  no_source_build
end
