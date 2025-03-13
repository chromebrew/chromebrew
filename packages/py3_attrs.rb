require 'buildsystems/pip'

class Py3_attrs < Pip
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  version "25.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6daadd3771f42ee6caecc67480f8d2b3e55c64a0fa34bbb172d0e66364128e08',
     armv7l: '6daadd3771f42ee6caecc67480f8d2b3e55c64a0fa34bbb172d0e66364128e08',
       i686: '0fd70a0eb459ee8184de360d2cf92d79ecd43162ddaf5c843cbb63ddb0a7534a',
     x86_64: '892c7de7e26e139c609588aba230efaff9c7be20a549880310c0e4bf876bf629'
  })

  depends_on 'python3' => :build
  depends_on 'py3_hatchling' => :build
  depends_on 'py3_hatch_vcs' => :build

  no_source_build
end
