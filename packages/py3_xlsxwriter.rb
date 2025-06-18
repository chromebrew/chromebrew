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
    aarch64: '798fe0dbb4f30024756faf9ce8ffe15c88b106e77d612d5e22b28726de37c1d4',
     armv7l: '798fe0dbb4f30024756faf9ce8ffe15c88b106e77d612d5e22b28726de37c1d4',
       i686: '7dd337832b3b1203c79061358187ae94feb0d8ae7833f26807a9ffe236a058ac',
     x86_64: '124c5e2239b9949318d153f73885f24bbea40bdce3ab164cbefea8e25fc70317'
  })

  depends_on 'python3' => :build

  no_source_build
end
