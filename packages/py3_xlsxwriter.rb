require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.2.5-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '754b8b545013ad865fed20ff76df1c08f3129d658bcf085743bab70ce24075e6',
     armv7l: '754b8b545013ad865fed20ff76df1c08f3129d658bcf085743bab70ce24075e6',
       i686: '7dd337832b3b1203c79061358187ae94feb0d8ae7833f26807a9ffe236a058ac',
     x86_64: '5ef22f2907c57080632ae335deeadc98b5a3fec71b19ce5f3eb04c22f38f613a'
  })

  depends_on 'python3' => :build

  no_source_build
end
