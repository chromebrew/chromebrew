require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "26.1.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51bc6760d7ed87403c58638bf13ddcb0fa2ec49021944be9335eb1307d51689f',
     armv7l: '51bc6760d7ed87403c58638bf13ddcb0fa2ec49021944be9335eb1307d51689f',
       i686: '67c9c76f554227027b0cbcaa432e5aa1aeb6efa496270a7bc517704004a9bbec',
     x86_64: '7acb18e80cdd033f8369019dff8bba7f450d4857cff6607ebfc5c41aef556da3'
  })

  depends_on 'python3' => :logical
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
