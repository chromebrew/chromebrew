require 'buildsystems/pip'

class Py3_setuptools_rust < Pip
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust'
  version "1.11.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c9a7cb3f968cc052cd6acce377aba961d66468e5276d2a2868c32d002186168',
     armv7l: '6c9a7cb3f968cc052cd6acce377aba961d66468e5276d2a2868c32d002186168',
       i686: '1a79527127c6331c5cc571da59c13202ce64bb386aa849db460e4a8914e24b85',
     x86_64: '28551667bdf1c9c87e443218ec0c659ffb85ded00c375181ab7587b221c185bf'
  })

  depends_on 'rust'
  depends_on 'py3_setuptools_scm' => :build
  depends_on 'py3_typing_extensions' => :build
  depends_on 'python3'

  no_source_build
end
