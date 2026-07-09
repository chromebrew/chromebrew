require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.31.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8ae75b725659b37f7938b4ce73c8648433c2c5bdcb9ac31258d6e738cc3f8511',
     armv7l: '8ae75b725659b37f7938b4ce73c8648433c2c5bdcb9ac31258d6e738cc3f8511',
       i686: '32722e8fdeee3c81c64f4f148c8e1874b38b6ecc1d7cb616ad6cb529d8d95d04',
     x86_64: '57357c8f10288679d443831f2fc6d1e4377f23ff6bdcf5d2b80d61a5a91f605a'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :logical

  no_source_build
end
