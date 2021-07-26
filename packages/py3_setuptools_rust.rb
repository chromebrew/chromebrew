require 'package'

class Py3_setuptools_rust < Package
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust/'
  @_ver = '0.12.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/setuptools-rust.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/0.12.1_armv7l/py3_setuptools_rust-0.12.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/0.12.1_armv7l/py3_setuptools_rust-0.12.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/0.12.1_x86_64/py3_setuptools_rust-0.12.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bff4567f3243e9bad84c6a7c1f6e902f3a1213054d6d25c32845cd32b4866bf7',
     armv7l: 'bff4567f3243e9bad84c6a7c1f6e902f3a1213054d6d25c32845cd32b4866bf7',
     x86_64: '2adf2ae4abf600713550e459ef379e97901895218f4cc7ef4654b81d3ea4d6a7'
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
