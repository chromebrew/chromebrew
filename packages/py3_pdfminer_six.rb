require 'package'

class Py3_pdfminer_six < Package
  description 'PDFminer.six is a community maintained fork of PDFminer.'
  homepage 'https://pdfminersix.readthedocs.io/'
  @_ver = '20201018'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pdfminer/pdfminer.six.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pdfminer_six/20201018-py3.11_armv7l/py3_pdfminer_six-20201018-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pdfminer_six/20201018-py3.11_armv7l/py3_pdfminer_six-20201018-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pdfminer_six/20201018-py3.11_i686/py3_pdfminer_six-20201018-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pdfminer_six/20201018-py3.11_x86_64/py3_pdfminer_six-20201018-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2ba0ca3c986d0513205530c8b7e1307427f1bf2fafe65c9160b70f7f75682607',
     armv7l: '2ba0ca3c986d0513205530c8b7e1307427f1bf2fafe65c9160b70f7f75682607',
       i686: '41e3e92aea50c8d43d6542d56c8eedaf1e71221a534d2c09b1887a7b40027213',
     x86_64: '81b51b7be0493c2e627d4ba6fef00030531b8ba68c01e2c7b952baf3586c214c'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
