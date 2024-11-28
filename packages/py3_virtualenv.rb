require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.28.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60c6f05571a2065ad280fc3f889a8ff7d222cc9461fa4539c9098a8b11bb5020',
     armv7l: '60c6f05571a2065ad280fc3f889a8ff7d222cc9461fa4539c9098a8b11bb5020',
       i686: '3d93cbb2df549028e822aacd61f616a79f79a68d075d9b5eb1ba63ea5fd2c2a2',
     x86_64: '8d8a064510e91a3d57b050362d3059a2e7ade6fa7fb215619712da5e0255d928'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
