require 'package'

class Py3_agate < Package
  description 'Agate is a data analysis library that is optimized for humans instead of machines.'
  homepage 'https://agate.readthedocs.io/'
  @_ver = '1.6.3'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.3-py3.11_armv7l/py3_agate-1.6.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.3-py3.11_armv7l/py3_agate-1.6.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.3-py3.11_i686/py3_agate-1.6.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.3-py3.11_x86_64/py3_agate-1.6.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b44c2ba8520c8da7508c25e9863f55e03cd26b7b414800ed4ecd22539fd03beb',
     armv7l: 'b44c2ba8520c8da7508c25e9863f55e03cd26b7b414800ed4ecd22539fd03beb',
       i686: '30a27d7c334f173cebda4fbddcd0c9c7e8d38c1764b04e8e8dfea982f2db25d6',
     x86_64: '29cc089ee330ddec15d566da1b78929c0ea78d6208fcbca8c710670f6ce5726d'
  })

  depends_on 'py3_babel'
  depends_on 'py3_six'
  depends_on 'py3_pyicu'
  depends_on 'py3_pytimeparse'
  depends_on 'py3_slugify'
  depends_on 'py3_isodate'
  depends_on 'py3_leather'
  depends_on 'py3_parsedatetime'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
