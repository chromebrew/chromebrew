require 'package'

class Py3_setuptools_rust < Package
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust/'
  @_ver = '1.1.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/setuptools-rust.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.1.2_armv7l/py3_setuptools_rust-1.1.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.1.2_armv7l/py3_setuptools_rust-1.1.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.1.2_i686/py3_setuptools_rust-1.1.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.1.2_x86_64/py3_setuptools_rust-1.1.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '04099645c42222d96d437fcc19fe0de20d69827f369c9097f784aa51a9948ba5',
     armv7l: '04099645c42222d96d437fcc19fe0de20d69827f369c9097f784aa51a9948ba5',
       i686: 'd44f823d537a817ad9b71aad7bb48b2dc0446bbcf7b7507f0ca26e6aaa56f083',
     x86_64: '721e1f3a97bfe023d6912abf20eb64bde96f76b587af245abad06481f2250e13'
  })

  depends_on 'rust'
  depends_on 'py3_toml'
  depends_on 'py3_semantic_version'
  depends_on 'py3_setuptools'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
