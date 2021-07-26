require 'package'

class Py3_docutils < Package
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  version '0.17.1'
  license 'BSD-2, GPL-3 and public-domain'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/docutils/files/docutils/0.17.1/docutils-0.17.1.tar.gz'
  source_sha256 '686577d2e4c32380bb50cbb22f575ed742d58168cee37e99117a854bcd88f125'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docutils/0.17.1_armv7l/py3_docutils-0.17.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docutils/0.17.1_armv7l/py3_docutils-0.17.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docutils/0.17.1_x86_64/py3_docutils-0.17.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7991b4f06ea92a83f2f3516f3c084e5a2800592164e70869e5c38751b5c9e593',
     armv7l: '7991b4f06ea92a83f2f3516f3c084e5a2800592164e70869e5c38751b5c9e593',
     x86_64: 'a78db8875de1b809b898334ae4026fb3b86ac87e4f6cc788c535702e70f037ba'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
