require 'buildsystems/pip'

class Py3_et_xmlfile < Pip
  description 'Et-xmlfile is an implementation of lxml\'s xmlfile module for the standard library\'s ElementTree.'
  homepage 'https://foss.heptapod.net/openpyxl/et_xmlfile'
  version "2.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd45898816dff926e3ebc4bab77d15c8c4b6c300d92515ba84f8cb976095b3681',
     armv7l: 'd45898816dff926e3ebc4bab77d15c8c4b6c300d92515ba84f8cb976095b3681',
       i686: '2915f9099e59667172ba597d1f05af860a3c561de08609017f38771a58cb010c',
     x86_64: 'c370592e83137d9a1cac18eb2c11a4e1208e6c4ed5d3cd2b6daf048812908f62'
  })

  depends_on 'python3' => :build

  no_source_build
end
