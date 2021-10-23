require 'package'

class Py3_jinja2 < Package
  description 'Jinja2 is a very fast and expressive template engine.'
  homepage 'https://jinja.palletsprojects.com/'
  @_ver = '3.0.2'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/jinja.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/3.0.2_armv7l/py3_jinja2-3.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/3.0.2_armv7l/py3_jinja2-3.0.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/3.0.2_i686/py3_jinja2-3.0.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/3.0.2_x86_64/py3_jinja2-3.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '876ca7ef5d436ba11bc31140ae62792600c4b87431ea3f6aa65eab1e8f35897a',
     armv7l: '876ca7ef5d436ba11bc31140ae62792600c4b87431ea3f6aa65eab1e8f35897a',
       i686: '98c179f92a98e39f75a05a327f7b81657ce304e22d2e350763099a54db2762ae',
     x86_64: 'd59fa896369b6a68594dad34005120ddd303a34ca14ac666f30682e5759d8188'
  })

  depends_on 'py3_markupsafe'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
