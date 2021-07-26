require 'package'

class Py3_certifi < Package
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/' # 403 Forbidden on 2021.05.08
  @_ver = '2020.12.05'
  version @_ver
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/certifi/python-certifi.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2020.12.05_armv7l/py3_certifi-2020.12.05-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2020.12.05_armv7l/py3_certifi-2020.12.05-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2020.12.05_x86_64/py3_certifi-2020.12.05-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '568f94b763dc5a616150ed572f8136f1f83dd852674311f7445206eb638bef70',
     armv7l: '568f94b763dc5a616150ed572f8136f1f83dd852674311f7445206eb638bef70',
     x86_64: '3e11a1836f36b685c668c0b149e8a1001c2b385df2fb35ebe24b800357526e84'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
