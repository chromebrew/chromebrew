require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "25.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8ba9fc4c95f3e344742279b8c14788a47f396bb2636e796f112103617f6f00f6',
     armv7l: '8ba9fc4c95f3e344742279b8c14788a47f396bb2636e796f112103617f6f00f6',
       i686: 'faaa6b8cb5235ba16b53966f6bab3fbd90ee7da094f285d64e9ddda965203fcf',
     x86_64: 'a3ca228dae824f6292839cd613325335396aa8dcea6289c41aa9a817cd69abed'
  })

  depends_on 'python3'
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
