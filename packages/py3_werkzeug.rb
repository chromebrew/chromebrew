require 'buildsystems/pip'

class Py3_werkzeug < Pip
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  version '3.0.4-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
