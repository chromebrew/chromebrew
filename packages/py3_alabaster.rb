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
    aarch64: '10b9ddfe6781a02d083960b194d2eab5dc2a41ff19ac3eb3a3c48dfb72afadc4',
     armv7l: '10b9ddfe6781a02d083960b194d2eab5dc2a41ff19ac3eb3a3c48dfb72afadc4',
       i686: '1b707698d8c67279a6b01a958cc055fb00d68fc553cc65c011d6851e8928cf80',
     x86_64: 'b89df2c58e7a2e291abf4a6ad3d9bfcc510ed2520055ffc95da51f7e88d137bf'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
