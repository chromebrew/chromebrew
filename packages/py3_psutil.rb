require 'package'

class Py3_psutil < Package
  description 'psutil is a cross-platform library for process and system monitoring in Python.'
  homepage 'https://github.com/giampaolo/psutil/'
  @_ver = '5.8.0'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/giampaolo/psutil.git'
  git_hashtag "release-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-py3.11_armv7l/py3_psutil-5.8.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-py3.11_armv7l/py3_psutil-5.8.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-py3.11_i686/py3_psutil-5.8.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-py3.11_x86_64/py3_psutil-5.8.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '081cca634ab2a2d6773de6d719fe81950d1ae89edf2917ec72c5a6b6fadbcde1',
     armv7l: '081cca634ab2a2d6773de6d719fe81950d1ae89edf2917ec72c5a6b6fadbcde1',
       i686: '5a975016897e70279ae72416221f75cd405451c159f2f5b00cfab9204c08e790',
     x86_64: '7f160be435bba0f50f8df6b42eeb7d4186e2c95cbcb927c16336443e133ebb81'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
