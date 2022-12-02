require 'package'

class Py3_pyelftools < Package
  description 'Pure-Python library for parsing and analyzing ELF files and DWARF debugging information.'
  homepage 'https://github.com/eliben/pyelftools/'
  @_ver = '0.29'
  version "#{@_ver}-py3.11"
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/eliben/pyelftools.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.29-py3.11_armv7l/py3_pyelftools-0.29-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.29-py3.11_armv7l/py3_pyelftools-0.29-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.29-py3.11_i686/py3_pyelftools-0.29-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.29-py3.11_x86_64/py3_pyelftools-0.29-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '705c080e39ddf3a95545b40e2fba1149d159c24e73635754fa1a9faecc3bbb02',
     armv7l: '705c080e39ddf3a95545b40e2fba1149d159c24e73635754fa1a9faecc3bbb02',
       i686: '570868d4967670730b3fa5d295a5db45c17421d27b3c6c973af0be3e423440a0',
     x86_64: '90b75c348286fc8f731f38a7bc3b8548989ea9416935008e36753928b7f61f97'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
