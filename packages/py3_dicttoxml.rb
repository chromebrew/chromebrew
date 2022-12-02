require 'package'

class Py3_dicttoxml < Package
  description 'DicttoXML converts Python dictionaries into XML strings.'
  homepage 'https://github.com/quandyfactory/dicttoxml/'
  @_ver = '1.3.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/quandyfactory/dicttoxml.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1-py3.11_armv7l/py3_dicttoxml-1.3.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1-py3.11_armv7l/py3_dicttoxml-1.3.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1-py3.11_i686/py3_dicttoxml-1.3.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dicttoxml/1.3.1-py3.11_x86_64/py3_dicttoxml-1.3.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '770f98a410c083273969377572d3b3d540f68c6d228a495b4d8117e48b343ce0',
     armv7l: '770f98a410c083273969377572d3b3d540f68c6d228a495b4d8117e48b343ce0',
       i686: '205e2c6a328b69c8321a31293c65c8cd9e1fb2a4da148209d0dde9b896cfbbfd',
     x86_64: '686a16d30dbbd3b22d9460497d93c322b541db7cccc65ed50802c9cbcb3cb806'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
