require 'package'

class Avocado < Package
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'https://avocado-framework.github.io/'
  version '82.0'
  license 'GPL-2 and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/avocado-framework/avocado/archive/82.0.tar.gz'
  source_sha256 '2c102186dd6ad017f767e1ee6faf0ed1dcfc78ebef9a580e795f122778551f0e'

  depends_on 'xdg_base'
  depends_on 'xzutils'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
