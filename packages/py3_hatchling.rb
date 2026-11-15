require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.33.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1eea22ab34ce370ed5dd242dd321e66093ada6ec61d6b3835f5e629a20b153d0',
     armv7l: '1eea22ab34ce370ed5dd242dd321e66093ada6ec61d6b3835f5e629a20b153d0',
       i686: '775b3de7e04d40afabc308497a7328e84389a3cc1d8255b41645843fbe4482ae',
     x86_64: 'd916165d8242a8311ccac4d094bde9af4e41ab54863e4c147461ea39b5998cef'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :logical

  no_source_build
end
