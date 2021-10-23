require 'package'

class Py3_wcwidth < Package
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  @_ver = '0.2.5'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jquast/wcwidth.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5-1_armv7l/py3_wcwidth-0.2.5-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5-1_armv7l/py3_wcwidth-0.2.5-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5-1_i686/py3_wcwidth-0.2.5-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5-1_x86_64/py3_wcwidth-0.2.5-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '75999c58929143521e7cab2b17da0679a0120c0c9630d5a0bb2097ed2a7932aa',
     armv7l: '75999c58929143521e7cab2b17da0679a0120c0c9630d5a0bb2097ed2a7932aa',
       i686: 'b8ee3efbe064a84920c4224bab8dde6e7fb2a0b40f934fbedf78575001592a58',
     x86_64: '769893b754e5e137406f0093b5255846f404c0c68784425b0869f6dd2312a94e'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
