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
    aarch64: '1702f6a5b09825b3a13dfbf4fa177c5797e39993fe4116cd8b953cb81e5cbd64',
     armv7l: '1702f6a5b09825b3a13dfbf4fa177c5797e39993fe4116cd8b953cb81e5cbd64',
       i686: '3bf1e520c8fff5c2257f57b5724c974bb50b3ff40815a22a7efc8c84a7fec5c7',
     x86_64: '98a19a32b437489cbee09cab56f5a44a77a4a45862e9a3e8c8d1cb2e91424b4a'
  })

  depends_on 'python3' => :build

  no_source_build
end
