require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.14-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a6f586724718e06928436b9586e24f84e745a72415c223283e29a2b082a8d85',
     armv7l: '6a6f586724718e06928436b9586e24f84e745a72415c223283e29a2b082a8d85',
       i686: '8759b87779517942f69cc122618eb49e5d2509c16c19b9cef51774ad16da1cae',
     x86_64: '3fbb88c5b7d1f1f5ce34c5894d001470c49d886802992fef27dedcb1b57aa800'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
