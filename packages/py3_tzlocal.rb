require 'package'

class Py3_tzlocal < Package
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  @_ver = '4.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/regebro/tzlocal.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tzlocal/4.1-py3.11_armv7l/py3_tzlocal-4.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tzlocal/4.1-py3.11_armv7l/py3_tzlocal-4.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tzlocal/4.1-py3.11_i686/py3_tzlocal-4.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tzlocal/4.1-py3.11_x86_64/py3_tzlocal-4.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6cda82249c10d50113f4f7ae0850d7bc9341f15d675d875d6bf3ae8651bc83a8',
     armv7l: '6cda82249c10d50113f4f7ae0850d7bc9341f15d675d875d6bf3ae8651bc83a8',
       i686: '6ba5b19f4aab57b0426a194f9c1f2b240b27f0bee011cd29c235c267f571d3b7',
     x86_64: '5b7dcb07f5dc953592f3d98442430593708efe823ead6c022026637af63200c1'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
