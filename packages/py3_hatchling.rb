require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.26.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '361758e415c060dd8c27bfbda418265d9cf2937cd4db19091ce5bbc49b609acb',
     armv7l: '361758e415c060dd8c27bfbda418265d9cf2937cd4db19091ce5bbc49b609acb',
       i686: '9b31d492b76cfc4e213a0a88bc07169c66a5fb006254b9e5240254a69c98c593',
     x86_64: '242c0818e3013ea665981505ae9880478e8c5cce94b91150d8aa117925d4f71f'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :build

  no_source_build
end
