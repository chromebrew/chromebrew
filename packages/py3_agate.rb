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
    aarch64: '4bf66fde013bc281a503d215457029b4367f68c7887920d038e8d6468184e1fa',
     armv7l: '4bf66fde013bc281a503d215457029b4367f68c7887920d038e8d6468184e1fa',
       i686: '39160b7d400b95db8cb31c203b58da97d4395fdf30f5fbc05a4042b4bd6f5ba5',
     x86_64: 'aeff8c3907cb6ffd66c4ce8b857df0646ac64a9b5d2576347185a80c58ce5fe6'
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
