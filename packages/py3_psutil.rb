require 'package'

class Py3_psutil < Package
  description 'Legacy compatibility packages.'
  homepage 'https://github.com/giampaolo/psutil/'
  @_ver = '5.8.0'
  version '5.8.0-1'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/giampaolo/psutil.git'
  git_hashtag "release-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-1_armv7l/py3_psutil-5.8.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-1_armv7l/py3_psutil-5.8.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-1_i686/py3_psutil-5.8.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_psutil/5.8.0-1_x86_64/py3_psutil-5.8.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '18ba9a9e443b4ad2881ea6d217b8dfacd5407c1f861fcda275cc75d8f9a11c43',
     armv7l: '18ba9a9e443b4ad2881ea6d217b8dfacd5407c1f861fcda275cc75d8f9a11c43',
       i686: 'f524b9fd9e96b751b4b3fcbe29362743ae2e6a5462781670db4f5a57a88756b8',
     x86_64: 'a1dcb3782e3fdf47407195c207f8e308433031ac050eeb8ef587351364188595'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
