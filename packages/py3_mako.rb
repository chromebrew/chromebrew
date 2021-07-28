require 'package'

class Py3_mako < Package
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  @_ver = '1.1.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sqlalchemy/mako.git'
  git_hashtag "rel_#{@_ver.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mako/1.1.4_armv7l/py3_mako-1.1.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mako/1.1.4_armv7l/py3_mako-1.1.4-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mako/1.1.4_x86_64/py3_mako-1.1.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e2de545b1cc564adcca01fedc0d9eae9d7960bf2b113ead1e5ea984112975e37',
     armv7l: 'e2de545b1cc564adcca01fedc0d9eae9d7960bf2b113ead1e5ea984112975e37',
     x86_64: 'abc167c04d84436e3760bc8274f4c78d1ab062f439829489ab90c5ec8521122c'
  })

  depends_on 'py3_markupsafe'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
