require 'buildsystems/pip'

class Py3_attrs < Pip
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  version "25.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '455e438ef279bc9bba45abb65b509159811a604213eeaba7a333d68aba69eeba',
     armv7l: '455e438ef279bc9bba45abb65b509159811a604213eeaba7a333d68aba69eeba',
       i686: '0fd70a0eb459ee8184de360d2cf92d79ecd43162ddaf5c843cbb63ddb0a7534a',
     x86_64: 'b3d57f4584356e2b6527ec424ca1a784cbbb2d4cca8c48ecae36a9e85db17543'
  })

  depends_on 'python3' => :build
  depends_on 'py3_hatchling' => :build
  depends_on 'py3_hatch_vcs' => :build

  no_source_build
end
