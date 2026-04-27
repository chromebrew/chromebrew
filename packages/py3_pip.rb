require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "26.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '19356da1c98c4c2bcb7dfb1a9fd3b5218dd7981d4d9b14c4a131a5ea25be3a5b',
     armv7l: '19356da1c98c4c2bcb7dfb1a9fd3b5218dd7981d4d9b14c4a131a5ea25be3a5b',
       i686: 'f6ce5f3a77db7e13dd8352bc3e8778d4da69f591593d86b16f431863792e4799',
     x86_64: '0c41d2fece186e4991e775da059efd9b473fe18763ee91a91b3593775b70b4cc'
  })

  depends_on 'python3' => :logical
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
