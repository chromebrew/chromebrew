require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.32.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca7b013a4ab7977fdfc657a1222811d389097752220f79b0d0b88a26c5175d5b',
     armv7l: 'ca7b013a4ab7977fdfc657a1222811d389097752220f79b0d0b88a26c5175d5b',
       i686: '29f30fa35119f6b6f68f6f374119ae4dd12b8220d47ab99687342da8ab7e5d94',
     x86_64: 'd77f40e2324f2effa9606b636c691269793e1aefb3dc2f93e9dd3a720e5f3081'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :logical

  no_source_build
end
