require 'buildsystems/pip'

class Py3_yamllint < Pip
  description 'YAMLlint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  version "1.37.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e12ae0c1325158e9a6265e2bef987487b09bd04fd4c69cd0a0a94b6f80939e78',
     armv7l: 'e12ae0c1325158e9a6265e2bef987487b09bd04fd4c69cd0a0a94b6f80939e78',
       i686: '5e121933c67351357bbeec084702c0b2c2aecfb54b59bbba642d6e3053ffc3d6',
     x86_64: 'd450ef698ab709a95f6fef6c584bb24f74d2f833fc29f7ace9c92d423db849d5'
  })

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :build

  no_source_build
end
