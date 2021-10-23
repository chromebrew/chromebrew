require 'package'

class Py3_setuptools_rust < Package
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust/'
  @_ver = '0.12.1'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/setuptools-rust.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/0.12.1-1_armv7l/py3_setuptools_rust-0.12.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/0.12.1-1_armv7l/py3_setuptools_rust-0.12.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/0.12.1-1_i686/py3_setuptools_rust-0.12.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/0.12.1-1_x86_64/py3_setuptools_rust-0.12.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a52ddd1fd3ce04d52bd6ba4b29ac1805eb5851d0bb078bb6fe1b78c1b6b2b26b',
     armv7l: 'a52ddd1fd3ce04d52bd6ba4b29ac1805eb5851d0bb078bb6fe1b78c1b6b2b26b',
       i686: 'ea05c426326393e53d48732d47e986c06933ae1ca75bd62d55c325c6216ada16',
     x86_64: '96b32e18e7ee25865588813aab09115e2a2e5eb43a8d4912ce4c0060475134a1'
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
