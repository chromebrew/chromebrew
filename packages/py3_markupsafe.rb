require 'package'

class Py3_markupsafe < Package
  description 'Markupsafe allows the safe addition of untrusted strings to HTML/XML markup.'
  homepage 'https://markupsafe.palletsprojects.com/'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/markupsafe.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1-py3.11_armv7l/py3_markupsafe-2.0.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1-py3.11_armv7l/py3_markupsafe-2.0.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1-py3.11_i686/py3_markupsafe-2.0.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1-py3.11_x86_64/py3_markupsafe-2.0.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ff24229b5e32308fdc3b5484d9bd978312f54dd801079d5d745d39225769ffdf',
     armv7l: 'ff24229b5e32308fdc3b5484d9bd978312f54dd801079d5d745d39225769ffdf',
       i686: '70a5a6f922b6baf91909af6c97541503a55e11f6a16f9824f59ad920dbf08ec1',
     x86_64: 'db3fa2c7949b255ca644833c3c0c967cfc4d50f906f7088b1412a1764e637c9d'
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
