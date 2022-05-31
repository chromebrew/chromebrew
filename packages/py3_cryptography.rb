require 'package'

class Py3_cryptography < Package
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  @_ver = '37.0.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyca/cryptography.git'
  git_hashtag @_ver

  depends_on 'py3_cffi'
  depends_on 'py3_six'
  depends_on 'py3_typing_extensions'
  depends_on 'py3_setuptools_rust' => :build
  depends_on 'rust' => :build

  def self.build
    system "python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
