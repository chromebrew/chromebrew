require 'package'

class Py3_attrs < Package
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  @_ver = '21.2.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-attrs/attrs.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/21.2.0-1_armv7l/py3_attrs-21.2.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/21.2.0-1_armv7l/py3_attrs-21.2.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/21.2.0-1_i686/py3_attrs-21.2.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/21.2.0-1_x86_64/py3_attrs-21.2.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9352f76874b690ce01024148c76cbedbabad5fad93c4706f770e03db18232c1e',
     armv7l: '9352f76874b690ce01024148c76cbedbabad5fad93c4706f770e03db18232c1e',
       i686: 'ffecad3b8c86a89784327cc36df6d27b12e40339b7df80a641b385816468763a',
     x86_64: 'ec386157827ee1da17cbc34b2fb1f6d54922d098c370055825e18be297799d55'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
