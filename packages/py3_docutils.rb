require 'package'

class Py3_docutils < Package
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  version '0.17.1'
  license 'BSD-2, GPL-3 and public-domain'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/docutils/files/docutils/0.17.1/docutils-0.17.1.tar.gz'
  source_sha256 '686577d2e4c32380bb50cbb22f575ed742d58168cee37e99117a854bcd88f125'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
