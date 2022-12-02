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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.28_armv7l/py3_pyelftools-0.28-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.28_armv7l/py3_pyelftools-0.28-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.28_i686/py3_pyelftools-0.28-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.28_x86_64/py3_pyelftools-0.28-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '969669befcac95f56ea469f66cced8d37728d89c92b87c6e11fa9b12943d0482',
     armv7l: '969669befcac95f56ea469f66cced8d37728d89c92b87c6e11fa9b12943d0482',
       i686: 'c6112ede652cbcb1f46efcdab9c5d66e73ab9483b9615a2d50ef2a00ba7bc735',
     x86_64: 'a43b98cb137c5c8093a497a39ae63d79d9c2ad0ef4ec08391392e099a962f5a4'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
