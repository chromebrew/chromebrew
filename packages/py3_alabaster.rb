require 'package'

class Py3_alabaster < Package
  description 'Alabaster is a configurable sidebar-enabled Sphinx theme.'
  homepage 'https://alabaster.readthedocs.io/'
  @_ver = '0.7.12'
  version "#{@_ver}-1"
  license 'BSD' # License is BSD-style, might be BSD-3?
  compatibility 'all'
  source_url 'https://github.com/bitprophet/alabaster.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.12-1_armv7l/py3_alabaster-0.7.12-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.12-1_armv7l/py3_alabaster-0.7.12-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.12-1_i686/py3_alabaster-0.7.12-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_alabaster/0.7.12-1_x86_64/py3_alabaster-0.7.12-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd6c4783e5580c9d1e934dd75181c2a13151d71398c27879e0ac9efc4888c7ce8',
     armv7l: 'd6c4783e5580c9d1e934dd75181c2a13151d71398c27879e0ac9efc4888c7ce8',
       i686: '55c46df2b001aeeababef44841ef9284bd0d77635875502396cb8d320a45c988',
     x86_64: '85cea802be3a36f4de9cc91ee1da3d50e4c618dbb0516a70c337acf77da1d58a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
