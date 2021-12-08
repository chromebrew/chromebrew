require 'package'

class Py3_dicttoxml < Package
  description 'DicttoXML converts Python dictionaries into XML strings.'
  homepage 'https://github.com/quandyfactory/dicttoxml/'
  @_ver = '1.3.1'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/quandyfactory/dicttoxml.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1-1_armv7l/py3_dicttoxml-1.3.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1-1_armv7l/py3_dicttoxml-1.3.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1-1_i686/py3_dicttoxml-1.3.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1-1_x86_64/py3_dicttoxml-1.3.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2459e21557c803a020f52def3b1fd3406da190374f748e417ddf9b5dc87bd2d4',
     armv7l: '2459e21557c803a020f52def3b1fd3406da190374f748e417ddf9b5dc87bd2d4',
       i686: 'a3a017a11de258f92caa103796c2aeae0419829451466995cfaa3bf1acb0175d',
     x86_64: '222342f4b707c392df4cac64f88c6fba192dbc60c236b47d8213f586f4e18385'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
