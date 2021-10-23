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
    aarch64: 'c7103a26b4591e1a486837714a5ac2cde818b94caf5eff1b99d59c065a01b307',
     armv7l: 'c7103a26b4591e1a486837714a5ac2cde818b94caf5eff1b99d59c065a01b307',
       i686: 'e8a3ffd3b4eb3d4435d01b1d9a6cfc194c5481194832e2140b6b0198848020d4',
     x86_64: '927183cd08ffe1b9bd63acfc805908ad15cc8c7673338e44941d07d0a1bcd981'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
