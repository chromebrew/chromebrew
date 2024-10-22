require 'buildsystems/pip'

class Py3_olefile < Pip
  description 'Olefile is a Python package to parse, read and write Microsoft OLE2 files.'
  homepage 'https://www.decalage.info/python/olefileio/'
  version "0.47-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aca8874d91d4702044720873773c28a2c9daf0de07dcd8a224a7f526a53d3e2b',
     armv7l: 'aca8874d91d4702044720873773c28a2c9daf0de07dcd8a224a7f526a53d3e2b',
       i686: '6a6dc1e2c93585795ffcb3a676f5f81cc4ffb6c62088997de14e5bcb2f89a3cc',
     x86_64: 'fe2d19153c3ca2887f51598a724df75017f71f0f096334063dca00e654758bdf'
  })

  depends_on 'python3' => :build

  no_source_build
end
