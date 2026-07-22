require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e6aa7cb40855fb6b2134e9c1f486546c205756c961bf6fd6652e13a18e1a55d4',
     armv7l: 'e6aa7cb40855fb6b2134e9c1f486546c205756c961bf6fd6652e13a18e1a55d4',
       i686: '446b0f54c77131e0ce1650018e1ef9aa12d011a7946bc641aa6871231bc8bd1e',
     x86_64: 'b44b32dca7f65065ecba84977e630b81665d77a5884ebffa19d8ae37dbb3931c'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
