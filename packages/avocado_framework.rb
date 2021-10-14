require 'package'

class Avocado_framework < Package
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'https://avocado-framework.github.io/'
  @_ver = '91.0'
  version @_ver
  license 'GPL-2 and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/avocado-framework/avocado.git'
  git_hashtag @_ver

  depends_on 'xdg_base'
  depends_on 'xzutils'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
