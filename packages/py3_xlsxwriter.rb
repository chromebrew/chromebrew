require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.2.3-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8c1e6b808db45746bda864f5423a1a2bfe386ebd6771ab8df8ef5cd12d6f107',
     armv7l: 'd8c1e6b808db45746bda864f5423a1a2bfe386ebd6771ab8df8ef5cd12d6f107',
       i686: 'f82638b6670a984525ab6f6a0accfc22ce04a025113ddc5ba4667425728aabb8',
     x86_64: 'e401a859a40a32a3dcd0f73616dc28ce7dc7e95b4690fa3dfa2fd8082411955d'
  })

  depends_on 'python3' => :build

  no_source_build
end
