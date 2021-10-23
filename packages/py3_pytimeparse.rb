require 'package'

class Py3_pytimeparse < Package
  description 'Pytimeparse is a small Python module to parse various kinds of time expressions. '
  homepage 'https://github.com/wroberts/pytimeparse/'
  @_ver = '1.1.8'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wroberts/pytimeparse.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-1_armv7l/py3_pytimeparse-1.1.8-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-1_armv7l/py3_pytimeparse-1.1.8-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-1_i686/py3_pytimeparse-1.1.8-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-1_x86_64/py3_pytimeparse-1.1.8-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '642ba7466ca2f27c960d9f04d82faa539e928e66d2c185a1d78e16f3a19d3836',
     armv7l: '642ba7466ca2f27c960d9f04d82faa539e928e66d2c185a1d78e16f3a19d3836',
       i686: '6ec512f9a164f4bcbb5281ee89c327e74e1bfbc46b0ce86cabc26fb939074f5f',
     x86_64: 'eec103f6bb52eb4c2b2b2af47f6ab9319553f5e66c290d688c0a555e133df907'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
