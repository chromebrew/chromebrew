require 'package'

class Py3_mako < Package
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  @_ver = '1.1.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sqlalchemy/mako.git'
  git_hashtag @_ver

  depends_on 'py3_markupsafe'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
