require 'buildsystems/pip'

class Py3_chardet < Pip
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  version '5.2.0-py3.12'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
