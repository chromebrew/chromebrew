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
    aarch64: '87749b646c38c19c1880bb52bdd975e491e6b90a786cfeda03d2b3d364005ee9',
     armv7l: '87749b646c38c19c1880bb52bdd975e491e6b90a786cfeda03d2b3d364005ee9',
       i686: 'f51aa6ce647fe132a86f98904dd6402ce45565583e16504c274564fd0aebed32',
     x86_64: '6bb02c660222f22f83d0c2d266796e54e3eac93e308a227bb19400c1a8fbd3ad'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
