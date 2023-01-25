require 'package'

class Py3_docutils < Package
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  @_ver = '0.19'
  version "#{@_ver}-py3.11"
  license 'BSD-2, GPL-3 and public-domain'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/6b/5c/330ea8d383eb2ce973df34d1239b3b21e91cd8c865d21ff82902d952f91f/docutils-0.19.tar.gz'
  source_sha256 '33995a6753c30b7f577febfc2c50411fec6aac7f7ffeb7c4cfe5991072dcf9e6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docutils/0.19-py3.11_armv7l/py3_docutils-0.19-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docutils/0.19-py3.11_armv7l/py3_docutils-0.19-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docutils/0.19-py3.11_i686/py3_docutils-0.19-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docutils/0.19-py3.11_x86_64/py3_docutils-0.19-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '08c87a5ec8b0c8f4e345db53cc288d6cf928567d8c87584c5e94bd6281c3995d',
     armv7l: '08c87a5ec8b0c8f4e345db53cc288d6cf928567d8c87584c5e94bd6281c3995d',
       i686: 'a29cb72bdc599b50fc2ffe44cc0658bfbae150dd70429524ebe6beca401802d6',
     x86_64: 'ad77384090df820e29cf07fffbfbe73f4eed0e0051051746761e7057e018a3cb'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
    # Needed for gdk_pixbuf build.
    FileUtils.ln "#{CREW_DEST_PREFIX}/bin/rst2man.py", "#{CREW_DEST_PREFIX}/bin/rst2man"
  end
end
