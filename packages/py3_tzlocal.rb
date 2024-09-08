require 'buildsystems/pip'

class Py3_tzlocal < Pip
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  version '5.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_pytz'
  depends_on 'python3' => :build

  no_compile_needed
end
