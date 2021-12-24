# NOTE: Archived upstream

require 'package'

class Py3_terminaltables < Package
  description 'Terminaltables generates simple tables in terminals from a nested list of strings.'
  homepage 'https://robpol86.github.io/terminaltables/'
  @_ver = '3.1.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Robpol86/terminaltables.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0-1_armv7l/py3_terminaltables-3.1.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0-1_armv7l/py3_terminaltables-3.1.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0-1_i686/py3_terminaltables-3.1.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0-1_x86_64/py3_terminaltables-3.1.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3402327fe2fb47c263923556f80c9610dd1f40ef3ad400cfc26a200d752f76c7',
     armv7l: '3402327fe2fb47c263923556f80c9610dd1f40ef3ad400cfc26a200d752f76c7',
       i686: '4bf3e71943804f649d8311de4bb3fcba4c7ccd0183da0bdf05ca0752f47bc962',
     x86_64: '881307f80761cf65fb01f7e5d349e7d2dde3ec04b48b9cde2865a03449107aa0'
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
