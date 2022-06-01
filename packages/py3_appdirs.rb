require 'package'

class Py3_appdirs < Package
  description 'Appdirs is a small Python module for determining appropriate platform-specific directories.'
  homepage 'https://github.com/ActiveState/appdirs/'
  @_ver = '1.4.4'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ActiveState/appdirs.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-1_armv7l/py3_appdirs-1.4.4-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-1_armv7l/py3_appdirs-1.4.4-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-1_i686/py3_appdirs-1.4.4-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-1_x86_64/py3_appdirs-1.4.4-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '91ce5fc0655bdf0d3a5fe0f3478d83d2ac0e10221cc73d13f9a99b167be5b4e9',
     armv7l: '91ce5fc0655bdf0d3a5fe0f3478d83d2ac0e10221cc73d13f9a99b167be5b4e9',
       i686: '0ff49dfa6f7140a41616e3e14c63d4a2d4e7925b752952bf78ac7595514f8727',
     x86_64: 'ef737c09133dd5f20d7cc7ac6ce0b8f8d2c8da581951fa95fa330d14f9b1ed59'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
