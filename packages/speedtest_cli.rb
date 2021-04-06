require 'package'

class Speedtest_cli < Package
  description 'Speedtest-cli is a command line interface for testing internet bandwidth using speedtest.net'
  homepage 'https://github.com/sivel/speedtest-cli/'
  version '2.1.2'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/sivel/speedtest-cli/archive/v2.1.2.tar.gz'
  source_sha256 'a877142eec0ee8dda86519c36fe789480ed6fa603b016b620affd77fbf79b0d9'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
