require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version '20.26.3-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_appdirs'
  depends_on 'py3_distlib'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_compile_needed
end
