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
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2_i686/py3_decorator-4.4.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_decorator/4.4.2_x86_64/py3_decorator-4.4.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'cf2a4b9f668587d4e4f0fe50f405e78fb864cb3d8f1fa707410382b39796509e',
     armv7l: 'cf2a4b9f668587d4e4f0fe50f405e78fb864cb3d8f1fa707410382b39796509e',
       i686: 'ab8512f18da0f1cef8a0b6d672d4a80dd79f07684df0090538a57f962864acdc',
     x86_64: '027b7964b559f03c6d1e787f46cbd9ad841c574095c0a008915f04ccb574af53'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
