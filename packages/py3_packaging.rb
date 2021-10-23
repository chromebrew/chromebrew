require 'package'

class Py3_packaging < Package
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  @_ver = '21.0'
  version @_ver
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/packaging.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.0_armv7l/py3_packaging-21.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.0_armv7l/py3_packaging-21.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.0_i686/py3_packaging-21.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.0_x86_64/py3_packaging-21.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'da19db5ea52fd5fb47c99f864b291225e4a88c4f7ceb236b9ad708e32d1041c3',
     armv7l: 'da19db5ea52fd5fb47c99f864b291225e4a88c4f7ceb236b9ad708e32d1041c3',
       i686: '55bf597a6657ca9a7cea2ae2922618ee4efc9403ce6bfc66913b75bc67908b69',
     x86_64: '12ad7efb1f2b8999ac78720e49524c952046a9bb4f2d63c49708b0dd0e9cc28a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
