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
       i686: 'af2f6126764a51ce1086c561ea9e1089a5af9e27f7e0783fd8653b1b64ab336c',
     x86_64: '8a1fcdf17f6d504c161333b64ea236fbb8b2e576ddd335f418737a4b39a40995'
  })

  depends_on 'python3'
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
