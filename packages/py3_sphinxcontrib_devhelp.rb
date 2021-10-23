require 'package'

class Py3_sphinxcontrib_devhelp < Package
  description 'Sphinxcontrib-devhelp is a sphinx extension which outputs a Devhelp document.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.2'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-devhelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2_armv7l/py3_sphinxcontrib_devhelp-1.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2_armv7l/py3_sphinxcontrib_devhelp-1.0.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2_i686/py3_sphinxcontrib_devhelp-1.0.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2_x86_64/py3_sphinxcontrib_devhelp-1.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '73b23ce00594787f58f255d6d5dba9073d50ae585a7262edeef6dccf3b024025',
     armv7l: '73b23ce00594787f58f255d6d5dba9073d50ae585a7262edeef6dccf3b024025',
       i686: '8754d599da11519830881634b7f14eb79c73ca17d02394ba51b62b0ede16f514',
     x86_64: 'ed7c79a55fec5e59b1773913a2000ceb50fa3a9cb0b8257948d73130f021bcca'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
