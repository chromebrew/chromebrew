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
    aarch64: '43f41e76a044594adedfe9606a29d416c89fb76d247bb1f03d541f5386bd139c',
     armv7l: '43f41e76a044594adedfe9606a29d416c89fb76d247bb1f03d541f5386bd139c',
       i686: '8aeb32bb55d468586d2b73208ce984a23594e7762cb5e0d758663bed7e883111',
     x86_64: '2f57af372503f3e7d249a5d2f310bd8e7c08b464045616867e9b72032c008456'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
