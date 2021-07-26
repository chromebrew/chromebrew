require 'package'

class Py3_tzlocal < Package
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  @_ver = '1.5.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/regebro/tzlocal.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tzlocal/1.5.1_armv7l/py3_tzlocal-1.5.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tzlocal/1.5.1_armv7l/py3_tzlocal-1.5.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tzlocal/1.5.1_x86_64/py3_tzlocal-1.5.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '65257a990b181d64c789ec90138e4254bd85ee43b179dbf355abaad4c6619091',
     armv7l: '65257a990b181d64c789ec90138e4254bd85ee43b179dbf355abaad4c6619091',
     x86_64: '218731e661685965ddeede0b02cf567e9c5344a7755dac09d07c3edb35b02174'
  })

  depends_on 'py3_pytz'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
