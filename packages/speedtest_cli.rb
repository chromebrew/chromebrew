require 'package'

class Speedtest_cli < Package
  description 'Command line interface for testing internet bandwidth using speedtest.net'
  homepage 'https://github.com/sivel/speedtest-cli/'
  @_ver = '2.1.3'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/sivel/speedtest-cli.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speedtest_cli/2.1.3_armv7l/speedtest_cli-2.1.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speedtest_cli/2.1.3_armv7l/speedtest_cli-2.1.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speedtest_cli/2.1.3_i686/speedtest_cli-2.1.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speedtest_cli/2.1.3_x86_64/speedtest_cli-2.1.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e0c2d3481a8130a64261b14ff26e3d1d6125ef04d5da09c25e0cd1b62e8b4ddf',
     armv7l: 'e0c2d3481a8130a64261b14ff26e3d1d6125ef04d5da09c25e0cd1b62e8b4ddf',
       i686: 'a6f8cfdb518de963d7735ba563ce65169219332e19c05b6dd0e6aee83d439fae',
     x86_64: 'b4d4633bd515f1991b63ca982893d3648b1f7e5f7849ffdd0e97c73832f34a9f'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
