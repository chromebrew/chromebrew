require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "26.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68b4dc8a2487e55dfe9693fc48b7208e40453f60cd7c903c857f4255931cd4e0',
     armv7l: '68b4dc8a2487e55dfe9693fc48b7208e40453f60cd7c903c857f4255931cd4e0',
       i686: '8b143dd48ac9013203c7b2d26a6245900308fa7f5424133fb2f9a49db9ddc3ca',
     x86_64: '85389dcb506f6974589433e6f45754ce02c7e92040e83317b513d13356492c80'
  })

  depends_on 'python3'
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
