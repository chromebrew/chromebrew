require 'buildsystems/pip'

class Py3_babel < Pip
  description 'Babel is an integrated collection of utilities that assist in internationalizing and localizing Python applications.'
  homepage 'https://babel.pocoo.org/'
  version '2.16.0-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'py3_pytz'
  depends_on 'python3' => :build
end
