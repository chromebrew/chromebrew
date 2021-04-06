require 'package'

class Py3_setuptools_rust < Package
  description 'setuptools-rust is a plugin for setuptools to build Rust Python extensions implemented with PyO3 or rust-cpython.'
  homepage 'https://github.com/PyO3/setuptools-rust/'
  version '0.12.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/12/22/6ba3031e7cbd6eb002e13ffc7397e136df95813b6a2bd71ece52a8f89613/setuptools-rust-0.12.1.tar.gz'
  source_sha256 '647009e924f0ae439c7f3e0141a184a69ad247ecb9044c511dabde232d3d570e'

  depends_on 'rust'
  depends_on 'py3_toml'
  depends_on 'py3_setuptools' => :build
  depends_on 'py3_semantic_version' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
