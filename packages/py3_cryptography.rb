require 'package'

class Py3_cryptography < Package
  description 'Cryptography provides cryptographic recipes and primitives to python developers.'
  homepage 'https://github.com/pyca/cryptography/'
  version '3.4.7'
  license 'Apache-2.0 or BSD'
  compatibility 'all'
  source_url 'https://github.com/pyca/cryptography/archive/3.4.7.tar.gz'
  source_sha256 '91061d435edc1c44f1f1d69a81eddc22e5a4749165b0457724d70ab6642cb6ce'

  # This package needs binaries

  depends_on 'py3_setuptools' => :build
  depends_on 'py3_setuptools_rust' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
