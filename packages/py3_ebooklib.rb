require 'package'

class Py3_ebooklib < Package
  description 'Ebooklib is a Python E-book library for handling books in EPUB2/EPUB3 format.'
  homepage 'https://docs.sourcefabric.org/projects/ebooklib/'
  @_ver = '0.17.1'
  version @_ver
  license 'AGPL-3'
  compatibility 'all'
  source_url 'https://github.com/aerkalov/ebooklib.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ebooklib/0.17.1_armv7l/py3_ebooklib-0.17.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ebooklib/0.17.1_armv7l/py3_ebooklib-0.17.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ebooklib/0.17.1_x86_64/py3_ebooklib-0.17.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9ef251c995198dbc2f0d9e63cbf9a7c03458ed7ea9b0aeea4eeb0e4465b5eb48',
     armv7l: '9ef251c995198dbc2f0d9e63cbf9a7c03458ed7ea9b0aeea4eeb0e4465b5eb48',
     x86_64: 'f805c0ac9fef8f5d9cdef29753d4a79d4b9eb83fe23fa0a1758282b29b7c7075'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
