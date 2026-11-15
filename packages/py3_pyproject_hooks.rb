require 'buildsystems/pip'

class Py3_pyproject_hooks < Pip
  description 'This package contains wrappers to call hooks on build backends for pyproject.toml -based projects'
  homepage 'https://pyproject-hooks.readthedocs.io/'
  version "1.3.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed88a4d566e5566a1da199dadf77fd8fdf39ace945993c1dbc9844656dbcf7c1',
     armv7l: 'ed88a4d566e5566a1da199dadf77fd8fdf39ace945993c1dbc9844656dbcf7c1',
       i686: '250285a2688d0f5214fffdb95c754c45a1d0f7860af6c1bb552568138d0db67e',
     x86_64: '17150bf580e32ba3b3a566674ec544660f83f2587acd74161a6b7569b9f45ddb'
  })

  depends_on 'py3_tomli'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
