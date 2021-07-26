require 'package'

class Py3_pytz < Package
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  @_ver = '2021.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/b0/61/eddc6eb2c682ea6fd97a7e1018a6294be80dba08fa28e7a3570148b4612d/pytz-2021.1.tar.gz'
  source_sha256 '83a4a90894bf38e243cf052c8b58f381bfe9a7a483f6a9cab140bc7f702ac4da'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2021.1_armv7l/py3_pytz-2021.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2021.1_armv7l/py3_pytz-2021.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2021.1_x86_64/py3_pytz-2021.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '385c77eef4a350e34c165cd7e229868bf1faee782bbce1f7a41d19d38792631c',
     armv7l: '385c77eef4a350e34c165cd7e229868bf1faee782bbce1f7a41d19d38792631c',
     x86_64: 'c33ae70cd50e9a09f5909eeebe227828011a79cd24b9325ab59b7b3d00214078'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
