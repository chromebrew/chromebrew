require 'buildsystems/pip'

class Py3_hatch_fancy_pypi_readme < Pip
  description 'MIT-licensed metadata plugin for Hatch'
  homepage 'https://github.com/hynek/hatch-fancy-pypi-readme'
  version "25.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50169a0ddfff4634f76854e1f3bf7108605a7cd2a3077b4b1b0234470c8a8491',
     armv7l: '50169a0ddfff4634f76854e1f3bf7108605a7cd2a3077b4b1b0234470c8a8491',
       i686: '0f3dae67d2d00b98c2af6ed7da83bcd411c116029a081060df0fffc9854a41d9',
     x86_64: 'e4694103b4236332d54788f89302377334a944e0683ca35cded50f6be1900183'
  })

  depends_on 'py3_hatch_vcs' => :build
  depends_on 'python3' => :build

  no_source_build
end
