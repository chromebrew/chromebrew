require 'buildsystems/pip'

class Py3_xlrd < Pip
  description 'XLRD is a library to extract data from Microsoft Excel (tm) spreadsheet files.'
  homepage 'https://xlrd.readthedocs.io/'
  version "2.0.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56d13a6d97e02ce9a431a823961f9af7a8459769fb4d3113cde7718254dc700b',
     armv7l: '56d13a6d97e02ce9a431a823961f9af7a8459769fb4d3113cde7718254dc700b',
       i686: '8edd9f2d55354d2ba1162d234ea459e4dcf7895b4343f01876828b1302ba9a71',
     x86_64: '266992051bbe6a0d383c9544d4173cd99b0e1342598d8ccd83315590898ed979'
  })

  depends_on 'python3' => :build

  no_source_build
end
