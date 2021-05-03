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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.27_armv7l/py3_pyelftools-0.27-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.27_armv7l/py3_pyelftools-0.27-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.27_i686/py3_pyelftools-0.27-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyelftools/0.27_x86_64/py3_pyelftools-0.27-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f5da6d42031d374f73344b9f13207c41c47ba8e571cd36ca45194eb60e5cd0fa',
     armv7l: 'f5da6d42031d374f73344b9f13207c41c47ba8e571cd36ca45194eb60e5cd0fa',
       i686: '17dcdddf5764b8ff2339ea037cfe9f5c7ab9cb29479f856dec0663ef093344a6',
     x86_64: '443dbb4e558e0c02066a22179e97122daccfac5d455e40ab67ec0f5dbf744f76'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
