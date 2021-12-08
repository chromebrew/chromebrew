require 'package'

class Py3_psutil < Package
  description 'psutil is a cross-platform library for process and system monitoring in Python.'
  homepage 'https://github.com/giampaolo/psutil/'
  @_ver = '5.8.0'
  version "#{@_ver}-2"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/giampaolo/psutil.git'
  git_hashtag "release-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-2_armv7l/py3_psutil-5.8.0-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-2_armv7l/py3_psutil-5.8.0-2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-2_i686/py3_psutil-5.8.0-2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-2_x86_64/py3_psutil-5.8.0-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '057244fca3ea15cff9a405bf6bb817bea914dbfb05c9df73b3557868172b446b',
     armv7l: '057244fca3ea15cff9a405bf6bb817bea914dbfb05c9df73b3557868172b446b',
       i686: '05a3dda9127409bec1e5768cbe420fcd43b418fb52b7b1d665bc0581011738c1',
     x86_64: '291c19700b40dc71833318e93bc5d7e228ea0087aa039fb66cad76a470279211'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
