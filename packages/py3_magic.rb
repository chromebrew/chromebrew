require 'package'

class Py3_magic < Package
  description 'Magic is a python wrapper for libmagic.'
  homepage 'https://github.com/ahupp/python-magic/'
  @_ver = '0.4.24'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ahupp/python-magic.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.24-py3.11_armv7l/py3_magic-0.4.24-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.24-py3.11_armv7l/py3_magic-0.4.24-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.24-py3.11_i686/py3_magic-0.4.24-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.24-py3.11_x86_64/py3_magic-0.4.24-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8cd2fb74448ce10f6bcde64b094554728d4789739a0fb19002cfb23b7558827a',
     armv7l: '8cd2fb74448ce10f6bcde64b094554728d4789739a0fb19002cfb23b7558827a',
       i686: 'b572c118c6fa4481930ee6a13163025d97473e17127cd406b327654ba759c308',
     x86_64: 'c341cb7743730084358816b2d16f07b3edb3e334e10218bb1daa73ac079f1300'
  })

  depends_on 'filecmd'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
