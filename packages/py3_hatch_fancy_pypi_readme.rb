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
    aarch64: 'b3e847d54e394038a5de1a93d16b27f4adb6a9abdd35a3b230d1a8d34eae2ed9',
     armv7l: 'b3e847d54e394038a5de1a93d16b27f4adb6a9abdd35a3b230d1a8d34eae2ed9',
       i686: '410e9ea1a39edc542f634acd308fb9f507a333736254864ea816858941c6c269',
     x86_64: 'e4694103b4236332d54788f89302377334a944e0683ca35cded50f6be1900183'
  })

  depends_on 'py3_hatch_vcs' => :build
  depends_on 'python3' => :build

  no_source_build
end
