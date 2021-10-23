require 'package'

class Py3_urllib3 < Package
  description 'URLlib3 is an HTTP library with thread-safe connection pooling, file post, and more.'
  homepage 'https://urllib3.readthedocs.io/'
  @_ver = '1.26.7'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/urllib3/urllib3.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.7_armv7l/py3_urllib3-1.26.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.7_armv7l/py3_urllib3-1.26.7-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.7_i686/py3_urllib3-1.26.7-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.7_x86_64/py3_urllib3-1.26.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '27660818e72babded41bfd6c00a2068d93415bad644f3a5eb86274a00085ca18',
     armv7l: '27660818e72babded41bfd6c00a2068d93415bad644f3a5eb86274a00085ca18',
       i686: 'd23d719cec90e996af8212b33433f2930fb20e8b1cdf41dbb6370f70d003c212',
     x86_64: 'de28a9b455b7c26aef0a27c5587c729776c4f4447c34cd6e17f68642fe4db992'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
