require 'package'

class Py3_alabaster < Package
  description 'Alabaster is a configurable sidebar-enabled Sphinx theme.'
  homepage 'https://alabaster.readthedocs.io/'
  @_ver = '0.7.12'
  version @_ver + '-1'
  license 'BSD' # License is BSD-style, might be BSD-3?
  compatibility 'all'
  source_url 'https://github.com/bitprophet/alabaster.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
