require 'buildsystems/pip'

class Py3_attrs < Pip
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  version "25.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6562f41da4903c3b458400149f3be057fa6ab457f65ffc1685c368eab2555f22',
     armv7l: '6562f41da4903c3b458400149f3be057fa6ab457f65ffc1685c368eab2555f22',
       i686: '79d1fa86da0956db415d1ffa58af6ce172ac1ddf96206523cee00a3d7b9bfdaa',
     x86_64: 'a44502301dcc0d21f362cbaa544b253f646d6a5e1c072a23ab07fe01ed13ac91'
  })

  depends_on 'python3' => :build
  depends_on 'py3_hatchling' => :build
  depends_on 'py3_hatch_vcs' => :build

  no_source_build
end
