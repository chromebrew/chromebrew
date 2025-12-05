require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "25.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0fda99f7d732d18a6e35ed4f646fafc712e1f83ac1d5f49ba89612ff19a70d11',
     armv7l: '0fda99f7d732d18a6e35ed4f646fafc712e1f83ac1d5f49ba89612ff19a70d11',
       i686: 'c9e3e1efd297e6705c4dcf29ce71c99514372fba0625feb488066f9c1df538f7',
     x86_64: 'febc4b731207ca89c0413a0c13e74b8eba3ffff9407498e790d3b0e506c58ae5'
  })

  depends_on 'python3'
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
