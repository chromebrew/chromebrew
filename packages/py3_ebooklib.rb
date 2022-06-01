require 'package'

class Py3_ebooklib < Package
  description 'Ebooklib is a Python E-book library for handling books in EPUB2/EPUB3 format.'
  homepage 'https://docs.sourcefabric.org/projects/ebooklib/'
  @_ver = '0.17.1'
  version "#{@_ver}-1"
  license 'AGPL-3'
  compatibility 'all'
  source_url 'https://github.com/aerkalov/ebooklib.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ebooklib/0.17.1-1_armv7l/py3_ebooklib-0.17.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ebooklib/0.17.1-1_armv7l/py3_ebooklib-0.17.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ebooklib/0.17.1-1_i686/py3_ebooklib-0.17.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ebooklib/0.17.1-1_x86_64/py3_ebooklib-0.17.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6708fde9d731ef359e5fa9fe775427b062f7d8bf2cb52fb3f524459c27bd3b0e',
     armv7l: '6708fde9d731ef359e5fa9fe775427b062f7d8bf2cb52fb3f524459c27bd3b0e',
       i686: 'aec9bb0a8f001b900d0794544778b20330a037744a415c29f4db90eae09fb039',
     x86_64: '7e7e7fdf0a20db6ccfe0ddc0ddd60ca0bdc01a56745855cf52ca565265eca466'
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
