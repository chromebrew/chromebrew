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
    aarch64: '557b047eefaed2a423616108d61187a5cd2e0afbe8095e583eeb6f70e98ba6ff',
     armv7l: '557b047eefaed2a423616108d61187a5cd2e0afbe8095e583eeb6f70e98ba6ff',
       i686: '59faf9c8c08a400e9dca233d220b8236fda5e823b6017760596f60af3770cd96',
     x86_64: 'cf30acab3973341a84b00eb5d3ad75bb76aec27d2d8bf0e6876ec5502d6cddd2'
  })

  depends_on 'python3' => :build
  depends_on 'py3_hatchling' => :build
  depends_on 'py3_hatch_vcs' => :build

  no_source_build
end
