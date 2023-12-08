require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  @_ver = '23.3.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag @_ver

  depends_on 'python3', '< 3.13.0'
  conflicts_ok

  no_compile_needed

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
