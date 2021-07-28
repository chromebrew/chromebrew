require 'package'

class Py3_itsdangerous < Package
  description 'ItsDangerous provide various helpers to pass data to untrusted environments and back.'
  homepage 'https://palletsprojects.com/p/itsdangerous/'
  @_ver = '1.1.0'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/itsdangerous.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/1.1.0_armv7l/py3_itsdangerous-1.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/1.1.0_armv7l/py3_itsdangerous-1.1.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/1.1.0_x86_64/py3_itsdangerous-1.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1a9e0553a57fe8ffc640b83b24b11da265fae3b9e7aacf7b69b113b32fb18ecb',
     armv7l: '1a9e0553a57fe8ffc640b83b24b11da265fae3b9e7aacf7b69b113b32fb18ecb',
     x86_64: 'c95d5c7d93517188a33c72f25342f55b74f230e8424ea50737e658de9ee087de'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
