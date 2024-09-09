require 'buildsystems/pip'

class Py3_colorama < Pip
  description 'Colorama makes ANSI color sequences work on MS Windows.'
  homepage 'https://github.com/tartley/colorama/'
  version '0.4.6-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_source_build
end
