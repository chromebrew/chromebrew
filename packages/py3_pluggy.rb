require 'package'

class Py3_pluggy < Package
  description 'Pluggy provides plugin and hook calling mechanisms for Python.'
  homepage 'https://pluggy.readthedocs.io/'
  @_ver = '1.0.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/pluggy.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.0.0_armv7l/py3_pluggy-1.0.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.0.0_armv7l/py3_pluggy-1.0.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.0.0_i686/py3_pluggy-1.0.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.0.0_x86_64/py3_pluggy-1.0.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '249e143babbdd5eb4e2f36435b25a65e0a67dc70b0f99c04bf5b6549a48471b1',
     armv7l: '249e143babbdd5eb4e2f36435b25a65e0a67dc70b0f99c04bf5b6549a48471b1',
       i686: '77f1ad02115e8559cadba76fb7d28f31646681400cb61ac67aed66bbdf0b3573',
     x86_64: '8ac08b55e1e90b5ebc2c40fc43d656a0bd02dd087405af7ebb793d3fb245274b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
