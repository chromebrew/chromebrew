require 'package'

class Speedtest_cli < Package
  description 'Command line interface for testing internet bandwidth using speedtest.net'
  homepage 'https://github.com/sivel/speedtest-cli/'
  @_ver = '2.1.3'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/sivel/speedtest-cli.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
