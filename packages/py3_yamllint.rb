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
    aarch64: '1b6f78511b70703572ff164e958a79ad653356dfd87f6c64a0f93e9666e09239',
     armv7l: '1b6f78511b70703572ff164e958a79ad653356dfd87f6c64a0f93e9666e09239',
       i686: '5e121933c67351357bbeec084702c0b2c2aecfb54b59bbba642d6e3053ffc3d6',
     x86_64: 'd450ef698ab709a95f6fef6c584bb24f74d2f833fc29f7ace9c92d423db849d5'
  })

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :build

  no_source_build
end
