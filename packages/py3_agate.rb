require 'buildsystems/pip'

class Py3_agate < Pip
  description 'Agate is a data analysis library that is optimized for humans instead of machines.'
  homepage 'https://agate.readthedocs.io/'
  version '1.12.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'py3_babel'
  depends_on 'py3_six'
  depends_on 'py3_pyicu'
  depends_on 'py3_pytimeparse'
  depends_on 'py3_slugify'
  depends_on 'py3_isodate'
  depends_on 'py3_leather'
  depends_on 'py3_parsedatetime'
  depends_on 'python3' => :build
end
