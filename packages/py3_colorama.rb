require 'package'

class Py3_colorama < Package
  description 'Colorama makes ANSI color sequences work on MS Windows.'
  homepage 'https://github.com/tartley/colorama/'
  @_ver = '0.4.4'
  version "#{@_ver}-1"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/tartley/colorama.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4-1_armv7l/py3_colorama-0.4.4-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4-1_armv7l/py3_colorama-0.4.4-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4-1_i686/py3_colorama-0.4.4-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4-1_x86_64/py3_colorama-0.4.4-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '96e02b9c3360a083ed1500fafba817e45a71a86064a306338eb020b3730bac47',
     armv7l: '96e02b9c3360a083ed1500fafba817e45a71a86064a306338eb020b3730bac47',
       i686: 'a4bc9fd6f3bd83b40bdcf8692d1e99e0f47b7a480e55ab18e62cf71b46a3ae5f',
     x86_64: '5e5a9635d836fdf49237f5df12fbdeee92f0cdbef2144cbe4c93529cfee2ee86'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
