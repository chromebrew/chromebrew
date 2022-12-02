require 'package'

class Py3_wcwidth < Package
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  @_ver = '0.2.5'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jquast/wcwidth.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5-py3.11_armv7l/py3_wcwidth-0.2.5-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5-py3.11_armv7l/py3_wcwidth-0.2.5-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5-py3.11_i686/py3_wcwidth-0.2.5-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.5-py3.11_x86_64/py3_wcwidth-0.2.5-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '964b2586d0aebaef7e56d716d1f956ee2eaebb221e43e569be5fa19885e4fdf4',
     armv7l: '964b2586d0aebaef7e56d716d1f956ee2eaebb221e43e569be5fa19885e4fdf4',
       i686: 'aa85eb4633a7ddd9f878a37bfa3ef859d1096a713f30ef07ab58076458bdcfa4',
     x86_64: '431c8702ac82bfe7b2f2c85ce4f066e1acc94c6ae0944a85a0bfa2e77598c304'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
