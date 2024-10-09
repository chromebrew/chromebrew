require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "24.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0c84b206d1c7b374b2836f70c49a59b070f7883ba6aac6375f5fa10644c4815',
     armv7l: 'f0c84b206d1c7b374b2836f70c49a59b070f7883ba6aac6375f5fa10644c4815',
       i686: '798d282cae2f1ab54dd296a4620f0232f0442083cd7015c22442bc7f71ae64e2',
     x86_64: 'd7c3e28add47fe06b2ea82b020016a272de67f3fc02de361844d8be207e22bc1'
  })

  depends_on 'python3', '< 3.13.0'
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
