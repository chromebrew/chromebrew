require 'package'

class Py3_parsedatetime < Package
  description 'Parse human-readable date/time strings'
  homepage 'https://github.com/bear/parsedatetime/'
  @_ver = '2.6'
  version "#{@_ver}-1"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bear/parsedatetime.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6-1_armv7l/py3_parsedatetime-2.6-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6-1_armv7l/py3_parsedatetime-2.6-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6-1_i686/py3_parsedatetime-2.6-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6-1_x86_64/py3_parsedatetime-2.6-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '736de0902d546e630af431eb1a41f3b4cc72345662b3728e63bbd1894a8f80d0',
     armv7l: '736de0902d546e630af431eb1a41f3b4cc72345662b3728e63bbd1894a8f80d0',
       i686: '0d8f9d7d91ce52a120558df06d9fb3017fd5278bf73fdb8a938f5e8c85e8dd65',
     x86_64: 'e1db932005ff12dbf34efe11232286760beec054e0a2fe6cfe9e8e70400e8c41'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
