require 'package'

class Py3_isodate < Package
  description 'ISOdate is an ISO 8601 date/time/duration parser and formatter.'
  homepage 'https://github.com/gweis/isodate/'
  @_ver = '0.6.0'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/gweis/isodate.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0_armv7l/py3_isodate-0.6.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0_armv7l/py3_isodate-0.6.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0_i686/py3_isodate-0.6.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0_x86_64/py3_isodate-0.6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '809a8a813a10a021e39c4f859a676950a374f95df05b67bda85a4c75ea4d185c',
     armv7l: '809a8a813a10a021e39c4f859a676950a374f95df05b67bda85a4c75ea4d185c',
       i686: '08043df182880abae97926fc4d172d1b20d0ed160967acb52a9d7d156f717710',
     x86_64: 'ee26e380cd8779368404be244d8d6388a49ca131436975c457eea7b107cde869'
  })

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
