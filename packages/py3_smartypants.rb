require 'package'

class Py3_smartypants < Package
  description 'Smartypants translates plain ASCII punctuation characters into "smart" typographic punctuation HTML entities.'
  homepage 'https://github.com/leohemsted/smartypants.py/'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/leohemsted/smartypants.py.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_smartypants/2.0.1-py3.11_armv7l/py3_smartypants-2.0.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_smartypants/2.0.1-py3.11_armv7l/py3_smartypants-2.0.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_smartypants/2.0.1-py3.11_i686/py3_smartypants-2.0.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_smartypants/2.0.1-py3.11_x86_64/py3_smartypants-2.0.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bec4ce321bb33f6d46eb49541f9c1fb2b43beadf159223e29f663bee6483c87a',
     armv7l: 'bec4ce321bb33f6d46eb49541f9c1fb2b43beadf159223e29f663bee6483c87a',
       i686: '5c2cbb1fc5a88c1ff3e29f678df81ca6a8ba15523f8e6e3df1e2ae58705bc136',
     x86_64: 'db69abe9f50050bb8daa8dd5091088717f8c3832e461b63b7617a6a30e7bd0eb'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
