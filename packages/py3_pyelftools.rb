require 'package'

class Py3_pyelftools < Package
  description 'Pure-Python library for parsing and analyzing ELF files and DWARF debugging information.'
  homepage 'https://github.com/eliben/pyelftools/'
  @_ver = '0.27'
  version @_ver
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/eliben/pyelftools.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.27_armv7l/py3_pyelftools-0.27-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.27_armv7l/py3_pyelftools-0.27-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.27_i686/py3_pyelftools-0.27-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.27_x86_64/py3_pyelftools-0.27-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b994942b282cb1c859b5001f16839476c4d99cd22a75b6f926342aa23d91444e',
     armv7l: 'b994942b282cb1c859b5001f16839476c4d99cd22a75b6f926342aa23d91444e',
       i686: '0826647dfdf8f0eea9d21e64d170dd5dbbe350145cf46d5ae3b42536dfa014f2',
     x86_64: 'a4fb7eb28776078f41b15bd41d25ed0f2ca70629186cacb305116ba0d7975dbe'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
