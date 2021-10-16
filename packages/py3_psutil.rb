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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-1_armv7l/py3_psutil-5.8.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-1_armv7l/py3_psutil-5.8.0-1-chromeos-armv7l.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-2_x86_64/py3_psutil-5.8.0-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '18ba9a9e443b4ad2881ea6d217b8dfacd5407c1f861fcda275cc75d8f9a11c43',
     armv7l: '18ba9a9e443b4ad2881ea6d217b8dfacd5407c1f861fcda275cc75d8f9a11c43',
    x86_64: '61e863bb00f473b6aae418093de26b2a43d14af5962572464c4770f76f607ac4'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
