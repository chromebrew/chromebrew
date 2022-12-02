require 'package'

class Py3_attrs < Package
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  @_ver = '21.2.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-attrs/attrs.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/21.2.0-py3.11_armv7l/py3_attrs-21.2.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/21.2.0-py3.11_armv7l/py3_attrs-21.2.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/21.2.0-py3.11_i686/py3_attrs-21.2.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/21.2.0-py3.11_x86_64/py3_attrs-21.2.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cc5c06ffb9a2c15e46cbeb00b2f3899857791ebd5cc41fdd135c95a110b7c9ef',
     armv7l: 'cc5c06ffb9a2c15e46cbeb00b2f3899857791ebd5cc41fdd135c95a110b7c9ef',
       i686: '5efa04af8a9ee8ed01b51de9b417106ae13b4d2b8500670fdc80aa5237a5d767',
     x86_64: 'cae9281510145bebf4032a78363c510ee3a9b866788fbb5056a13231a81d4962'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
