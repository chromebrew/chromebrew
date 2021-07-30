require 'package'

class Py3_decorator < Package
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  @_ver = '4.4.2'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/micheles/decorator.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2_armv7l/py3_decorator-4.4.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2_armv7l/py3_decorator-4.4.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2_x86_64/py3_decorator-4.4.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3b5cf4a06faa87a5f7cd6ac40f035d78f416c71529cf264f1ebd042170024689',
     armv7l: '3b5cf4a06faa87a5f7cd6ac40f035d78f416c71529cf264f1ebd042170024689',
     x86_64: 'c5cf9f13a699189e71e43f362b0e17447f4ee1cd01cebb8aaf6d2074efaab2d8'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
