require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.10.10-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53164a0b0f07952493934545e8eec8897f5d917236d58710d215c104886322f7',
     armv7l: '53164a0b0f07952493934545e8eec8897f5d917236d58710d215c104886322f7',
       i686: 'a8f18512a3670691cb8bca26aa6885890835fb6a10a48e22f37fcc93c483e29f',
     x86_64: 'dd4def3dcd80032a852da6eda991a63c1175ec7f5abc592e36a2a9c554cee904'
  })

  depends_on 'python3' => :logical
  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
