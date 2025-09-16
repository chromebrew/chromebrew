require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.2.9-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '907dacb948bc8e442a1e40dff9cd55c51b89606242e96a3acb6b7f0de619482b',
     armv7l: '907dacb948bc8e442a1e40dff9cd55c51b89606242e96a3acb6b7f0de619482b',
       i686: '290317a5dbbad3940844f8d9684b9e0c0a02151ac31ba4feec2b1ffcd58efc3b',
     x86_64: 'd7d5b55d87548c71d6df707a42eb94ab02aa6cdbfc5d8937c7b878d26b3b04b5'
  })

  depends_on 'python3' => :build

  no_source_build
end
