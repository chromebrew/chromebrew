require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.16.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0b6901ce9306a4fad87b674eceb4841b37e8299d24a766a14a358c70805f332',
     armv7l: 'b0b6901ce9306a4fad87b674eceb4841b37e8299d24a766a14a358c70805f332',
       i686: '4cb9f924aaa7822c91c128b51bfaf2bba18ca33a510b8a2cfa4647583327a2d8',
     x86_64: '674a6f61d9794a73613636d1a859a72839359400cb597c09b54756a0e1f7cfa1'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
