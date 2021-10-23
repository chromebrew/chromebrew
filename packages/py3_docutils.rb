require 'package'

class Py3_docutils < Package
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  @_ver = '0.17.1'
  version "#{@_ver}-1"
  license 'BSD-2, GPL-3 and public-domain'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/4c/17/559b4d020f4b46e0287a2eddf2d8ebf76318fd3bd495f1625414b052fdc9/docutils-0.17.1.tar.gz'
  source_sha256 '686577d2e4c32380bb50cbb22f575ed742d58168cee37e99117a854bcd88f125'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docutils/0.17.1-1_armv7l/py3_docutils-0.17.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docutils/0.17.1-1_armv7l/py3_docutils-0.17.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docutils/0.17.1-1_i686/py3_docutils-0.17.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docutils/0.17.1-1_x86_64/py3_docutils-0.17.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '171c83350d1edf6b3601a5917fcb7bcefe068fff4ee31d7ec5770cdf127f7f09',
     armv7l: '171c83350d1edf6b3601a5917fcb7bcefe068fff4ee31d7ec5770cdf127f7f09',
       i686: '97eccc95b24fcdd216ca6fc02ab4e1a6844f357795a608bd3d862ad3cdbe518a',
     x86_64: 'f70f9fc51f5a96bb9a6123f6a6ac3cf33e1f3b55f73f78f8c7860235e5563383'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
