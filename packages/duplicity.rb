require 'package'

class Duplicity < Package
  description 'Duplicity backs directories by producing encrypted tar-format volumes and uploading them to a remote or local file server.'
  homepage 'http://duplicity.nongnu.org/'
  version '0.8.19'
  compatibility 'all'
  license 'GPL-3'
  source_url 'https://files.pythonhosted.org/packages/9f/ae/4eb8869a12a531f453ef1d64a0d53dfa6a674895f6222b347f8c96a7a88b/duplicity-0.8.19.tar.gz'
  source_sha256 'd5dda2918058d0e47bf7a1299cfc9b51cc2f0546920fc3cfcf7ae06fc76d68ba'

  depends_on 'librsync'
  depends_on 'gnupg'
  depends_on 'openssh'
  depends_on 'py3_future'
  depends_on 'py3_fasteners'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
