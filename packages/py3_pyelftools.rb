require 'package'

class Py3_pyelftools < Package
  description 'Pure-Python library for parsing and analyzing ELF files and DWARF debugging information.'
  homepage 'https://github.com/eliben/pyelftools/'
  @_ver = '0.27'
  version "#{@_ver}-1"
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/eliben/pyelftools.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.27-1_armv7l/py3_pyelftools-0.27-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.27-1_armv7l/py3_pyelftools-0.27-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.27-1_i686/py3_pyelftools-0.27-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.27-1_x86_64/py3_pyelftools-0.27-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'cee59c129fbccd6f72d2ea45ba82cc0d986bcf8c42ed4813a473781d8a73538a',
     armv7l: 'cee59c129fbccd6f72d2ea45ba82cc0d986bcf8c42ed4813a473781d8a73538a',
       i686: '9105d58b8bbf878aa48c558dbcf11394b24272610ebfdc5ad4b0185023daa0f6',
     x86_64: '5c2a2b09a2a480f4be521ac6075d14c7ed07bce390603370c76c4c23e08666ef'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
