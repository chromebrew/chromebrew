require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version '3.2.0-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40312a9a1a4d8899cb1c4c8da4449501d4454e82abbe9639f244fc0c9c5319a1',
     armv7l: '40312a9a1a4d8899cb1c4c8da4449501d4454e82abbe9639f244fc0c9c5319a1',
       i686: '060c677a99ded43c53eb827b1acc246bc96cc6f5c7a321d9ac4d75e06ca67516',
     x86_64: 'ecf288d983ea80d91518275bde03a0d9f365451703e92fdb90be8df9f3262147'
  })

  depends_on 'python3' => :build

  no_source_build
end
