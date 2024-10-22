require 'buildsystems/pip'

class Py3_et_xmlfile < Pip
  description 'Et-xmlfile is an implementation of lxml\'s xmlfile module for the standard library\'s ElementTree.'
  homepage 'https://foss.heptapod.net/openpyxl/et_xmlfile'
  version "1.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f79b53c24a330038f3611307cde553b988209fe7eea27e1db2414a66dd1b5354',
     armv7l: 'f79b53c24a330038f3611307cde553b988209fe7eea27e1db2414a66dd1b5354',
       i686: '1d1fb5560fc141c850d8de33d066a0c862e7aa116b325fa7075db07cc0e3871b',
     x86_64: 'a7a9edb62823ac9a4fba20ba04d1d48814c8b6f9d08c574e29a9ca65793abb91'
  })

  depends_on 'python3' => :build

  no_source_build
end
