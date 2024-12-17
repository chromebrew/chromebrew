require 'buildsystems/pip'

class Py3_attrs < Pip
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  version "24.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a785e7de88f7c6260cf9406baf45f8fe148f31544e27ed8d4c6fc5d03c708c87',
     armv7l: 'a785e7de88f7c6260cf9406baf45f8fe148f31544e27ed8d4c6fc5d03c708c87',
       i686: '59faf9c8c08a400e9dca233d220b8236fda5e823b6017760596f60af3770cd96',
     x86_64: 'cf30acab3973341a84b00eb5d3ad75bb76aec27d2d8bf0e6876ec5502d6cddd2'
  })

  depends_on 'python3' => :build
  depends_on 'py3_hatchling' => :build
  depends_on 'py3_hatch_vcs' => :build

  no_source_build
end
