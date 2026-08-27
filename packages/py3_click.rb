require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.5.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bbb33a0b3ab544c1ad040b7e2a6481285bcce9277bcd9dea9844c9fb5823ef35',
     armv7l: 'bbb33a0b3ab544c1ad040b7e2a6481285bcce9277bcd9dea9844c9fb5823ef35',
       i686: 'a68f73b94fc9cf9dc15248d687efa84c6d4de6d1807abd710ce408044e76c8c4',
     x86_64: '9eccc7324ef6359236bfcf3e72ca6b284aa0fa2bc251bf843799d8f72163dd90'
  })

  depends_on 'python3' => :logical

  no_source_build
end
