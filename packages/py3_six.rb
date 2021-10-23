require 'package'

class Py3_six < Package
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  @_ver = '1.16.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/benjaminp/six.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_six/1.16.0_armv7l/py3_six-1.16.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_six/1.16.0_armv7l/py3_six-1.16.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_six/1.16.0_i686/py3_six-1.16.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_six/1.16.0_x86_64/py3_six-1.16.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9dba1c50aba2700e82b87dd6cefdb63eb3f052a7d3d98cb245bfa4e3de7f63e1',
     armv7l: '9dba1c50aba2700e82b87dd6cefdb63eb3f052a7d3d98cb245bfa4e3de7f63e1',
       i686: '503e7c9a6b20b0a338e65703236e333fe862b6dc30eb503b9a0e510713713396',
     x86_64: '2a93ba10370eaed486901f30d6dd95d1ee99a8f6dcf3183f6bb3f47b7f01ed81'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
