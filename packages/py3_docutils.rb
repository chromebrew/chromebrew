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
    aarch64: '89a62ed3b047061fe765329171a91e76d7e113006136fbbb25311f6ce1692309',
     armv7l: '89a62ed3b047061fe765329171a91e76d7e113006136fbbb25311f6ce1692309',
       i686: 'a906df40046622e6b6e13220da7b03a5adcf677127d9da6ebe1bba3734aa683b',
     x86_64: '5db96f75f85e79f9f69fed41f4c5739996626d1a288fbd35ef9a22c10d169b75'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
