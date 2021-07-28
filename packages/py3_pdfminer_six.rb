require 'package'

class Py3_pdfminer_six < Package
  description 'PDFminer.six is a community maintained fork of PDFminer.'
  homepage 'https://pdfminersix.readthedocs.io/'
  @_ver = '20201018'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pdfminer/pdfminer.six.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pdfminer_six/20201018_armv7l/py3_pdfminer_six-20201018-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pdfminer_six/20201018_armv7l/py3_pdfminer_six-20201018-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pdfminer_six/20201018_x86_64/py3_pdfminer_six-20201018-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0190554a998298faa773b29a8a29746627dcfeea528a58c7149bed1f9d4f8093',
     armv7l: '0190554a998298faa773b29a8a29746627dcfeea528a58c7149bed1f9d4f8093',
     x86_64: '00e565527c66c64c8f61ccfcbd8f283c7e77002115fdd24cd27f7e2a8c99e901'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
