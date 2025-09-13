require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.2.6-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c908bcf76b5ec913f95ec7ff9f9b9e9924b9e0cc612fdcf533f1b7babe0bf16',
     armv7l: '6c908bcf76b5ec913f95ec7ff9f9b9e9924b9e0cc612fdcf533f1b7babe0bf16',
       i686: 'f5a23f745021efe604214953856ac791ed98c2bc60702f3caa892a5e9bba6029',
     x86_64: 'c99a6533272051b4cad59b272c0ae951650bd13c5004ad6b5949f9a0f48f03b3'
  })

  depends_on 'python3' => :build

  no_source_build
end
