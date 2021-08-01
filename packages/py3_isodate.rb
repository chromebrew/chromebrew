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
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0_x86_64/py3_isodate-0.6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0b45d4ecab2b2ca8706e1de22e8918c8d6cf100bab2e8085fb8976cb3a7d0015',
     armv7l: '0b45d4ecab2b2ca8706e1de22e8918c8d6cf100bab2e8085fb8976cb3a7d0015',
     x86_64: '3d204a492c1b418a2fa77d810d4756a1c78aafc6eb87113e17d4ff04b70aa190'
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
