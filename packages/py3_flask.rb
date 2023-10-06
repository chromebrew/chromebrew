require 'buildsystems/pip'

class Py3_flask < Pip
  description 'Flask is a simple framework for building complex web applications.'
  homepage 'https://palletsprojects.com/p/flask/'
  @_ver = '2.0.2'
  version "#{@_ver}-py3.12"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_werkzeug'
  depends_on 'py3_itsdangerous'
  depends_on 'py3_click'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_compile_needed
end
