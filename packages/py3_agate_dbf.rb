require 'buildsystems/pip'

class Py3_agate_dbf < Pip
  description 'Agate-dbf adds read support for DBF files to agate.'
  homepage 'https://agate-dbf.readthedocs.org/'
  version "0.2.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5518619adf1c1aabacdd130125d6906282047d62f90872c9b1c7a7c47a4a1771',
     armv7l: '5518619adf1c1aabacdd130125d6906282047d62f90872c9b1c7a7c47a4a1771',
       i686: '3dfb198fb21df2e02c02636c93aa8a2e55649b7a5d68cffcee0dc57cedbb0d3a',
     x86_64: '8a53e4d0e6d93ae9d504c1d02070cc8126f8d8ca7c1522e9dc5bbf633a46185e'
  })

  depends_on 'py3_dbfread'
  depends_on 'py3_agate'
  depends_on 'python3' => :build

  no_source_build
end
