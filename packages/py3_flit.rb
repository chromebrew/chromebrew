require 'buildsystems/pip'

class Py3_flit < Pip
  description 'Flit provides simplified packaging of Python modules.'
  homepage 'https://flit.pypa.io/'
  version "4.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '403488e7c6e30fabd76b8c25095407015f49e271e6318c038cdbbd0b6ae8cead',
     armv7l: '403488e7c6e30fabd76b8c25095407015f49e271e6318c038cdbbd0b6ae8cead',
       i686: '22eaafaac5b848a7d180b9dd51997664c8095e1973cad9ac00bf1e59a0c795cb',
     x86_64: 'f8cae61f2e8653ede024b464a4256219f3ba5213886285f24ae8fe08069b57f6'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_flit_core'
  depends_on 'py3_tomli'
  depends_on 'py3_tomli_w'
  depends_on 'python3' => :logical

  no_source_build
end
