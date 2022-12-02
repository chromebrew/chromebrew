require 'package'

class Py3_slugify < Package
  description 'Python-slugify returns unicode slugs.'
  homepage 'https://github.com/un33k/python-slugify/'
  @_ver = '5.0.2'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/un33k/python-slugify.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/5.0.2-py3.11_armv7l/py3_slugify-5.0.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/5.0.2-py3.11_armv7l/py3_slugify-5.0.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/5.0.2-py3.11_i686/py3_slugify-5.0.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/5.0.2-py3.11_x86_64/py3_slugify-5.0.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c1d3983e1fb3d4cb7bf98fae380010818088c9327ac176b871bf136cb244f0fc',
     armv7l: 'c1d3983e1fb3d4cb7bf98fae380010818088c9327ac176b871bf136cb244f0fc',
       i686: '12384d33e9edeff40d54d219e7877b4be3e77da02165c14ccb5192d47b3b9ec9',
     x86_64: 'd7d11795a5632c8d1c5c155ad9139830fc2e4bd8acb811ed458ed9deb08ea1cc'
  })

  depends_on 'py3_text_unidecode'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
