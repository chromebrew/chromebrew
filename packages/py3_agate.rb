require 'buildsystems/pip'

class Py3_agate < Pip
  description 'Agate is a data analysis library that is optimized for humans instead of machines.'
  homepage 'https://agate.readthedocs.io/'
  version "1.13.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '996f1eda8177dcf16765511247b031f7a5d66024519119788f13e10bba5c7928',
     armv7l: '996f1eda8177dcf16765511247b031f7a5d66024519119788f13e10bba5c7928',
       i686: '2196dbedccdfc64161c63602e5ac17ff4bc97b5ea5cad9d727cb347f105b0719',
     x86_64: '46c6d7c22ccbf2df8af0bc019434e54ae41b5b483508e647ba4624fec21fabd6'
  })

  depends_on 'py3_babel'
  depends_on 'py3_six'
  depends_on 'py3_pyicu'
  depends_on 'py3_pytimeparse'
  depends_on 'py3_slugify'
  depends_on 'py3_isodate'
  depends_on 'py3_leather'
  depends_on 'py3_parsedatetime'
  depends_on 'python3' => :build

  no_source_build
end
