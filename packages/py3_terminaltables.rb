require 'package'

class Py3_terminaltables < Package
  description 'Terminaltables generates simple tables in terminals from a nested list of strings.'
  homepage 'https://robpol86.github.io/terminaltables/'
  @_ver = '3.1.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Robpol86/terminaltables.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0_armv7l/py3_terminaltables-3.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0_armv7l/py3_terminaltables-3.1.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0_x86_64/py3_terminaltables-3.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '28a47e04b0adeaa207368d2ff7783778a3cac4901422908cbafce54f2b608921',
     armv7l: '28a47e04b0adeaa207368d2ff7783778a3cac4901422908cbafce54f2b608921',
     x86_64: 'e47536692ca04ff487ff0619ba71ed592e5dcf2cc0583b9a0b523f9da5487a88'
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
