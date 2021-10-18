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
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-2_x86_64/py3_psutil-5.8.0-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '27109725b7c9df19f4692365354a113acf8816336eb0b2aa97afb65c508efd13',
     armv7l: '27109725b7c9df19f4692365354a113acf8816336eb0b2aa97afb65c508efd13',
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
