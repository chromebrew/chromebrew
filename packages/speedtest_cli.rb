require 'package'

class Speedtest_cli < Package
  description 'Command line interface for testing internet bandwidth using speedtest.net'
  homepage 'https://github.com/sivel/speedtest-cli/'
  @_ver = '2.1.3'
  version "#{@_ver}-1"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/sivel/speedtest-cli.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speedtest_cli/2.1.3-1_armv7l/speedtest_cli-2.1.3-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speedtest_cli/2.1.3-1_armv7l/speedtest_cli-2.1.3-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speedtest_cli/2.1.3-1_i686/speedtest_cli-2.1.3-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speedtest_cli/2.1.3-1_x86_64/speedtest_cli-2.1.3-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a41204bdd87203d372eaf0c9276e46d485baf3e487cb75e3aa99c4fd91ee2fce',
     armv7l: 'a41204bdd87203d372eaf0c9276e46d485baf3e487cb75e3aa99c4fd91ee2fce',
       i686: '1bd5754845ee4f548ec18fbaa94da9d3426c489eb290491b9967bf0dc3d09538',
     x86_64: '72123fd6389ff0c7c9d0855a5eb6010f88e1e86742d6bc13d8f58faabf6e170b'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
