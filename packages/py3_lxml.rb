require 'package'

class Py3_lxml < Package
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  @_ver = '4.9.1'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/lxml/lxml.git'
  git_hashtag "lxml-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_lxml/4.9.1-py3.11_armv7l/py3_lxml-4.9.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_lxml/4.9.1-py3.11_armv7l/py3_lxml-4.9.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_lxml/4.9.1-py3.11_i686/py3_lxml-4.9.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_lxml/4.9.1-py3.11_x86_64/py3_lxml-4.9.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0a3c0b190f0a9d5187aacfb2e16e5a1a36f11629ae5493ea1e1f5f60a56168e4',
     armv7l: '0a3c0b190f0a9d5187aacfb2e16e5a1a36f11629ae5493ea1e1f5f60a56168e4',
       i686: '2cb5e17d85385a5305a714e28c5af5bbb62070e110a502227718f53da2bd759e',
     x86_64: '01b2be20303249f5ffaa89499d6903ba6210ae74355c017c06b9087921467177'
  })

  depends_on 'py3_cython' => :build
  depends_on 'python3' => :build
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
