require 'package'

class Py3_arrow < Package
  description 'Arrow is a Python library that offers a sensible and human-friendly approach to creating, manipulating, formatting and converting dates, times and timestamps.'
  homepage 'https://arrow.readthedocs.io/'
  @_ver = '0.17.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/arrow-py/arrow.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/0.17.0_armv7l/py3_arrow-0.17.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/0.17.0_armv7l/py3_arrow-0.17.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/0.17.0_x86_64/py3_arrow-0.17.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ce488d8ba3142883bdd45ed20816d6be886453b098edc09a6d7d886b82c926bb',
     armv7l: 'ce488d8ba3142883bdd45ed20816d6be886453b098edc09a6d7d886b82c926bb',
     x86_64: 'd74a3e9dd7d6c4af0e6a7a8f08e3f3d680a4126f7e2f72d4586eff9d32b74fa9'
  })

  depends_on 'py3_dateutil'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
