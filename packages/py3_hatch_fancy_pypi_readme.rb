require 'buildsystems/pip'

class Py3_hatch_fancy_pypi_readme < Pip
  description 'MIT-licensed metadata plugin for Hatch'
  homepage 'https://github.com/hynek/hatch-fancy-pypi-readme'
  version "24.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8aca80ea95d7b71d86f96155d4f373c961c47e4897b7e0fda50b00a06970cfde',
     armv7l: '8aca80ea95d7b71d86f96155d4f373c961c47e4897b7e0fda50b00a06970cfde',
       i686: 'e881518b83fcc4fb7110761009c542c6d04da2d93681cdedbe142a735fc3a513',
     x86_64: '26483a0530742581c26b20447c42f884e2d74e3304a85f0ef7a3be7235b173db'
  })

  depends_on 'py3_hatch_vcs' => :build
  depends_on 'python3' => :build

  no_source_build
end
