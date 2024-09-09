require 'buildsystems/pip'

class Py3_docwriter < Pip
  description 'API documentation generator of the FreeType library.'
  homepage 'https://gitlab.freedesktop.org/freetype/docwriter'
  version '1.3.3-py3.12'
  license 'FTL and GPL-2'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_source_build
end
