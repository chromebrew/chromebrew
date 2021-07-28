require 'package'

class Py3_alabaster < Package
  description 'Alabaster is a configurable sidebar-enabled Sphinx theme.'
  homepage 'https://alabaster.readthedocs.io/'
  @_ver = '0.7.12'
  version @_ver
  license 'BSD' # License is BSD-style, might be BSD-3?
  compatibility 'all'
  source_url 'https://github.com/bitprophet/alabaster.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.12_armv7l/py3_alabaster-0.7.12-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.12_armv7l/py3_alabaster-0.7.12-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.12_x86_64/py3_alabaster-0.7.12-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9f3a1bad1ec31d93269f89680d5c35a13a08f4a95ce8a551867cecc5f1360370',
     armv7l: '9f3a1bad1ec31d93269f89680d5c35a13a08f4a95ce8a551867cecc5f1360370',
     x86_64: '91b8482cab6e522d127eb12a500e558bd4e75cc9c4aa2a15d6740d910234a766'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
