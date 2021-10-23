require 'package'

class Py3_itsdangerous < Package
  description 'ItsDangerous provide various helpers to pass data to untrusted environments and back.'
  homepage 'https://palletsprojects.com/p/itsdangerous/'
  @_ver = '2.0.1'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/itsdangerous.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/2.0.1_armv7l/py3_itsdangerous-2.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/2.0.1_armv7l/py3_itsdangerous-2.0.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/2.0.1_i686/py3_itsdangerous-2.0.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/2.0.1_x86_64/py3_itsdangerous-2.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'cab715a48b5dce3ad1be74186a801c62e5863730cf32b230150e32726bd84486',
     armv7l: 'cab715a48b5dce3ad1be74186a801c62e5863730cf32b230150e32726bd84486',
       i686: '32918b5d832cf28eb0adc8b29094c00a1cee666df893f93522f8407fc6eec6ed',
     x86_64: '0c3694d6cc147b02a27251fa11c2067817323b1fda937c2a175ba2f9ea06b1ea'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
