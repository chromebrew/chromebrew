require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "25.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef1dda8eb7b3a70c223f67ed13edcb20d1a2ea4f85fb60954e82af8ffec19b06',
     armv7l: 'ef1dda8eb7b3a70c223f67ed13edcb20d1a2ea4f85fb60954e82af8ffec19b06',
       i686: 'd58c437c62e8cd2f7e5091eb32fac4e153ba2f99991367ebe5686f5a4a0ae24d',
     x86_64: '73d47d6d860db91e6f6d972d4fce3cd98b10eb9e16906bc7345825b101aebe80'
  })

  depends_on 'python3'
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
