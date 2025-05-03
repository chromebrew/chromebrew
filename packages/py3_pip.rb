require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "25.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23e5b17d24f4dde73235507c00c38a6437e74463d674cd8c080d92e84c23939d',
     armv7l: '23e5b17d24f4dde73235507c00c38a6437e74463d674cd8c080d92e84c23939d',
       i686: 'faaa6b8cb5235ba16b53966f6bab3fbd90ee7da094f285d64e9ddda965203fcf',
     x86_64: '5219dc705b2cf79ecb5c52ab6116f643b6fa03d9778c6b18d6e705c8e434e7b9'
  })

  depends_on 'python3'
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
