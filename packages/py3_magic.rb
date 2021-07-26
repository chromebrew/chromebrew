require 'package'

class Py3_magic < Package
  description 'Magic is a python wrapper for libmagic.'
  homepage 'https://github.com/ahupp/python-magic/'
  @_ver = '0.4.22'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ahupp/python-magic.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.22_armv7l/py3_magic-0.4.22-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.22_armv7l/py3_magic-0.4.22-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.22_x86_64/py3_magic-0.4.22-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c86ecb80682a8c66d4bc71243c3bfd4985248c9ebd11b9306e90263d204dfa35',
     armv7l: 'c86ecb80682a8c66d4bc71243c3bfd4985248c9ebd11b9306e90263d204dfa35',
     x86_64: '358ae56e26512e33ed4527e342226ab81e6bfeda40f85391a839cf557b7c6a57'
  })

  depends_on 'filecmd'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
