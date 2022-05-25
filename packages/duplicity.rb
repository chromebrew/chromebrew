require 'package'

class Duplicity < Package
  description 'Duplicity backs directories by producing encrypted tar-format volumes and uploading them to a remote or local file server.'
  homepage 'http://duplicity.nongnu.org/'
  version '0.8.20'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/84/65/5ca97dade5527b6a93757e88455c53b0d7002322f9d47d848c35902ef431/duplicity-0.8.20.tar.gz'
  source_sha256 '488af2ecadb059214074f2b3ac51bf9d7de55a800e37ccc2f1075cd0a74940e3'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duplicity/0.8.20_armv7l/duplicity-0.8.20-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duplicity/0.8.20_armv7l/duplicity-0.8.20-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duplicity/0.8.20_i686/duplicity-0.8.20-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duplicity/0.8.20_x86_64/duplicity-0.8.20-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bcab1c51132837f0455ac7eeed0d9247c8c7ba4bc07cce885d25acf1dc083eb3',
     armv7l: 'bcab1c51132837f0455ac7eeed0d9247c8c7ba4bc07cce885d25acf1dc083eb3',
       i686: 'f2a67c6ff638d25808a46bd936a9a0eeb6da88635cf4cc61c33afc5cdef47c0a',
     x86_64: 'badd683b26a5d10d0b850d5b9ffff5092a7031fabde4583fce5c217ac0e90fdc'
  })

  depends_on 'librsync'
  depends_on 'gnupg'
  depends_on 'openssh'
  depends_on 'py3_future'
  depends_on 'py3_fasteners'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
