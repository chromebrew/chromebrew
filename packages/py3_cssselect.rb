require 'buildsystems/pip'

class Py3_cssselect < Pip
  description 'CSSselect parses CSS3 Selectors and translates them to XPath 1.0.'
  homepage 'https://cssselect.readthedocs.io/'
  version '1.2.0-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
