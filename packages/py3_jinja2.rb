require 'package'

class Py3_jinja2 < Package
  description 'Jinja2 is a very fast and expressive template engine.'
  homepage 'https://jinja.palletsprojects.com/'
  @_ver = '3.0.2'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/jinja.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/3.0.2-py3.11_armv7l/py3_jinja2-3.0.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/3.0.2-py3.11_armv7l/py3_jinja2-3.0.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/3.0.2-py3.11_i686/py3_jinja2-3.0.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jinja2/3.0.2-py3.11_x86_64/py3_jinja2-3.0.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6d09c41fc7605e8ab3adfa39f784be484856289d443694412e73751b287bf5de',
     armv7l: '6d09c41fc7605e8ab3adfa39f784be484856289d443694412e73751b287bf5de',
       i686: '4e740b5baac3f75e173a0469e9b659636eba87037b4beca6282961133fe165ab',
     x86_64: '344728efda908b6d5af7de6746062d107e6fdcdfccab0f41be34aded2c5a59f7'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
