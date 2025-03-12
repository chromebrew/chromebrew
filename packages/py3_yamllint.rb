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
    aarch64: 'f92fdd8aaf510f6ddb6b50aae8cf5ab7583e08885e48d9e20b28328d8c23eb27',
     armv7l: 'f92fdd8aaf510f6ddb6b50aae8cf5ab7583e08885e48d9e20b28328d8c23eb27',
       i686: '8890c359a9d711a0923b6c79a350b8f36c52303135d82fbcccd6644a0ab57a7a',
     x86_64: '767b2d7e8481c16cfb2e5ed5dc158e4d68b0d3db26a6f4f484b6866ef5689f20'
  })

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :build

  no_source_build
end
