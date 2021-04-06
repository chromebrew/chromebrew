require 'package'

class Py3_certifi < Package
  description 'Certifi provides Mozilla’s carefully curated collection of Root Certificates for validating the trustworthiness of SSL certificates while verifying the identity of TLS hosts.'
  homepage 'https://certifiio.readthedocs.io/' # certifi.io reports 403 forbidden
  version '2020.12.05'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/certifi/python-certifi/archive/2020.12.05.tar.gz'
  source_sha256 '2434d33b445587b2f767fc56390589809b799fb218b5fb97697ed93989953adf'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
