require 'buildsystems/pip'

class Py3_jinja2 < Pip
  description 'Jinja2 is a very fast and expressive template engine.'
  homepage 'https://jinja.palletsprojects.com/'
  version '3.1.4-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  no_compile_needed
end
