require 'package'

class Py3_docwriter < Package
  description 'API documentation generator of the FreeType library.'
  homepage 'https://gitlab.freedesktop.org/freetype/docwriter'
  @_ver = '1.3.2'
  version "#{@_ver}-py3.11"
  license 'FTL and GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/freetype/docwriter.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docwriter/1.3.2-py3.11_armv7l/py3_docwriter-1.3.2-py3.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docwriter/1.3.2-py3.11_armv7l/py3_docwriter-1.3.2-py3.11-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docwriter/1.3.2-py3.11_i686/py3_docwriter-1.3.2-py3.11-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docwriter/1.3.2-py3.11_x86_64/py3_docwriter-1.3.2-py3.11-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '89c3bf73a9f8eec6edc87f87389ca3e894515bcd19577190efe1a767ac346bc2',
     armv7l: '89c3bf73a9f8eec6edc87f87389ca3e894515bcd19577190efe1a767ac346bc2',
       i686: 'ae61d78d147d3b818122c0fc026e29423098c21cc8683042883a42d951b09ee7',
     x86_64: '131f7d941dddd29d926d0b9f26b9215107bb797efc77884e428781795e9acb1c'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
