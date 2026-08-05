require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "26.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74498ef69be5a2c71ecf194b9385a9e80fcdc19f55268b4de80464370531ae3e',
     armv7l: '74498ef69be5a2c71ecf194b9385a9e80fcdc19f55268b4de80464370531ae3e',
       i686: '6d37558bd4005aec30b0db00d11f2281d29fb26fb31815dc84432becc79631dd',
     x86_64: 'eac9c52f12f24c95539375a5eae72eee9a55f90c0728e03f1aa4384c5141739e'
  })

  depends_on 'python3' => :logical
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
