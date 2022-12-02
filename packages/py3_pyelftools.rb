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
    aarch64: '507c5cb7f67912c4f58751e1f2355bba66db769347413914b172bb1597a7894c',
     armv7l: '507c5cb7f67912c4f58751e1f2355bba66db769347413914b172bb1597a7894c',
       i686: '4832ba057d09781193e13c422f6ebe2cc4559b9fc610bfdeb5bf8d81a7e8ca8d',
     x86_64: '5bbf7eb6f58583ba570a591b953c411acd7fb31d2263edec7c72b7793ad104ca'
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
