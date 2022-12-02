require 'package'

class Py3_ebooklib < Package
  description 'Ebooklib is a Python E-book library for handling books in EPUB2/EPUB3 format.'
  homepage 'https://docs.sourcefabric.org/projects/ebooklib/'
  @_ver = '0.17.1'
  version "#{@_ver}-py3.11"
  license 'AGPL-3'
  compatibility 'all'
  source_url 'https://github.com/aerkalov/ebooklib.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ebooklib/0.17.1-py3.11_armv7l/py3_ebooklib-0.17.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ebooklib/0.17.1-py3.11_armv7l/py3_ebooklib-0.17.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ebooklib/0.17.1-py3.11_i686/py3_ebooklib-0.17.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ebooklib/0.17.1-py3.11_x86_64/py3_ebooklib-0.17.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c0326da8b32c6036614ed049ed37cd06c0bd0c9937ceb50f6cb1e9cfe7dcd7a5',
     armv7l: 'c0326da8b32c6036614ed049ed37cd06c0bd0c9937ceb50f6cb1e9cfe7dcd7a5',
       i686: '0bc47b2ba2f0385bae85c2d2983516bab10c463c3d0acbd5165e030aa0ef899d',
     x86_64: '7cebe377c7b48b93f56552d4a616ef94e7cf462fc23394bf77a26c4ad343d9fe'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
