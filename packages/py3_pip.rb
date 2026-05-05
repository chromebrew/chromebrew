require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "26.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c0e31007871ec79dfca9933c232b53cebf9b735470204351455d8f4da9d9cd6',
     armv7l: '2c0e31007871ec79dfca9933c232b53cebf9b735470204351455d8f4da9d9cd6',
       i686: '5c33a78b45d8cbe1a6dbae3354e03fc7ca89cfc91652a51f87fb47ab298b1a4a',
     x86_64: '432f2d4738e87d5c0e55db2f590b1ae47b6ccf2ad7c7484f5618d5e7c87dc69e'
  })

  depends_on 'python3' => :logical
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
