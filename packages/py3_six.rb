require 'buildsystems/pip'

class Py3_six < Pip
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  version "1.17.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8bb227d628114e79702220ba7e3035f8f48ab0ff3f1064c8e2f36f78f92e086',
     armv7l: 'a8bb227d628114e79702220ba7e3035f8f48ab0ff3f1064c8e2f36f78f92e086',
       i686: '6c23e30ba94bbbbd555efa4d7757e4e86d05f8a7cefa893d813ad7b50e64de8c',
     x86_64: '396e08d33183e11ebe309a64c8c45d5b0f7cd2898a60c60203a7521c9741cd7a'
  })

  depends_on 'python3' => :build

  no_source_build
end
