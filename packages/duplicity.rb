require 'package'

class Duplicity < Package
  description 'Duplicity backs directories by producing encrypted tar-format volumes and uploading them to a remote or local file server.'
  homepage 'http://duplicity.nongnu.org/'
  version '0.8.19'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/84/65/5ca97dade5527b6a93757e88455c53b0d7002322f9d47d848c35902ef431/duplicity-0.8.20.tar.gz'
  source_sha256 '488af2ecadb059214074f2b3ac51bf9d7de55a800e37ccc2f1075cd0a74940e3'

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
