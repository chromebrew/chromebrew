require 'buildsystems/pip'

class Py3_twine < Pip
  description 'A utility for interacting with PyPI'
  homepage 'https://pypi.python.org/pypi/twine'
  version "6.0.1-#{CREW_PY_VER}"
  license 'APACHE'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95b0a369e80bf461091524edee8aba4274d074ea955cc169c8dd7d014eb67cac',
     armv7l: '95b0a369e80bf461091524edee8aba4274d074ea955cc169c8dd7d014eb67cac',
       i686: 'ce48f9f7ef59204077358f8be2b8372667ab34d3f930b6aaa41db465d3e83719',
     x86_64: '6ffdaf7f4cf707411023a8708e74ff656945d54f9742be3bc2df024798801087'
  })

  depends_on 'py3_setuptools'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
