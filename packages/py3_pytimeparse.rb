require 'package'

class Py3_pytimeparse < Package
  description 'Pytimeparse is a small Python module to parse various kinds of time expressions. '
  homepage 'https://github.com/wroberts/pytimeparse/'
  @_ver = '1.1.8'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wroberts/pytimeparse.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8_armv7l/py3_pytimeparse-1.1.8-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8_armv7l/py3_pytimeparse-1.1.8-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8_x86_64/py3_pytimeparse-1.1.8-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0d51a50a382749a31a884549ac6914bf9c43fc6937eb5c330c083b050fed74f8',
     armv7l: '0d51a50a382749a31a884549ac6914bf9c43fc6937eb5c330c083b050fed74f8',
     x86_64: 'fcfab1dc5a048c57fd8a465fc1f3df01bb74e938f10a627c7c327f3eb3dc280f'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
