require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.29.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da47fa449a226cb8201a6cb8eee8d0d9de23eb047b6094e403113caee8f60bae',
     armv7l: 'da47fa449a226cb8201a6cb8eee8d0d9de23eb047b6094e403113caee8f60bae',
       i686: 'efb93de7aa4669ae2058dda0208e0e1270f8bd3aaaf67829073b11965e5ecaae',
     x86_64: 'efa149bcbe7ab6bb05e43123a92947823b77d13ce0d5539dfffde55829b19401'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
