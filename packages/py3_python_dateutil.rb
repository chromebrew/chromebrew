require 'buildsystems/pip'

class Py3_python_dateutil < Pip
  description 'Dateutil provides extensions to the standard Python datetime module.'
  homepage 'https://dateutil.readthedocs.io/'
  version "4.0.0-#{CREW_PY_VER}"
  license 'BSD-3 and Apache-2.0 or BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '463a4b7ab5b004ba11efe375d1989e5a419755fe2afeedb9a14ddcee57a67481',
     armv7l: '463a4b7ab5b004ba11efe375d1989e5a419755fe2afeedb9a14ddcee57a67481',
       i686: '1d8c931a98087e1c8dd3c05fc5fb1f9bf69b1ce8b46f089a7a461993ad5f2e24',
     x86_64: 'bbd6c968e85fc82df0abd9515652b714647e9823bfbe313cff449bb3ad9d4234'
  })

  depends_on 'python3' => :logical

  no_source_build
end
