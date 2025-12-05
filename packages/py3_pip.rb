require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "25.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6723755da724e0c6b3fada4b216c558e8ec465dcc60c1bbdd0df9e34cd6b456f',
     armv7l: '6723755da724e0c6b3fada4b216c558e8ec465dcc60c1bbdd0df9e34cd6b456f',
       i686: 'c9e3e1efd297e6705c4dcf29ce71c99514372fba0625feb488066f9c1df538f7',
     x86_64: '67c05319b80d55494147f980a44143842f82c87d81fd3597d18737d704d4d83a'
  })

  depends_on 'python3'
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
