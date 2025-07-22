require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.32.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72e425c2d956c2d59750f91fc28a00389e7c7f1e75594e6cc857f5b4f1727b14',
     armv7l: '72e425c2d956c2d59750f91fc28a00389e7c7f1e75594e6cc857f5b4f1727b14',
       i686: '45d27d2817bc95094808906bfe9ed4d398266a26f881173dbe31a21055c2311c',
     x86_64: 'ae416e75e1c1a6bd1cfc33624eb64ce5c47b3b61b1cfe61eb38349913c26217f'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
