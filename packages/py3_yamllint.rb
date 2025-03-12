require 'buildsystems/pip'

class Py3_yamllint < Pip
  description 'YAMLlint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  version "1.36.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f61ac8c3a4ee1b7f4db75a34789bc9d3f9216a8b6c060597c782e727f457d8c',
     armv7l: '0f61ac8c3a4ee1b7f4db75a34789bc9d3f9216a8b6c060597c782e727f457d8c',
       i686: '8890c359a9d711a0923b6c79a350b8f36c52303135d82fbcccd6644a0ab57a7a',
     x86_64: '1ed3a642e4b5e1926800ff51481c35af6d93e0d6c6ab4dc2f017ef65e0e04f7c'
  })

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :build

  no_source_build
end
