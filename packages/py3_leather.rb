require 'package'

class Py3_leather < Package
  description 'Leather is a fast, approximate chart generator in Python.'
  homepage 'https://leather.readthedocs.io/'
  @_ver = '0.3.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/leather.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.4_armv7l/py3_leather-0.3.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.4_armv7l/py3_leather-0.3.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.4_i686/py3_leather-0.3.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_leather/0.3.4_x86_64/py3_leather-0.3.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f8711a1a2dd533ec8dea9f2cd0eefc3792454b0b25b89e165756b8713e1bd513',
     armv7l: 'f8711a1a2dd533ec8dea9f2cd0eefc3792454b0b25b89e165756b8713e1bd513',
       i686: '7bfc6948f14bccaa320b48ac0e1c16ce1666b9b76aab27cade06de52e38afc94',
     x86_64: 'ddf12b877c0260cca61e9326939aa3f7ce6cf593139331bf42d51915f3e39c84'
  })

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
