require 'package'

class Py3_configparser < Package
  description 'Configparser backports newer configparser modules to earlier python versions.'
  homepage 'https://github.com/jaraco/configparser/'
  @_ver = '5.0.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jaraco/configparser.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2_armv7l/py3_configparser-5.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2_armv7l/py3_configparser-5.0.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2_x86_64/py3_configparser-5.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '239d87ea1922fd8ae501b603011f8ddb4212026dd6e72bf3bf750ee5dd3cb277',
     armv7l: '239d87ea1922fd8ae501b603011f8ddb4212026dd6e72bf3bf750ee5dd3cb277',
     x86_64: 'e45b32190ef07b77b65cc4648ac8f0c2a3f7752d2f872c5f9b3e97b198956e3f'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
