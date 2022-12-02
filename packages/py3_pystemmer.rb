require 'package'

class Py3_pystemmer < Package
  description 'Snowball stemming algorithms, for information retrieval'
  homepage 'http://snowball.tartarus.org'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.11"
  license 'BSD MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/55/b2/c3aeebfe4a60256ddb72257e750a94c26c3085f017b7e58c860d5aa91432/PyStemmer-2.0.1.tar.gz'
  source_sha256 '9b81c35302f1d2a5ad9465b85986db246990db93d97d3e8f129269ed7102788e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1-py3.11_armv7l/py3_pystemmer-2.0.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1-py3.11_armv7l/py3_pystemmer-2.0.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1-py3.11_i686/py3_pystemmer-2.0.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1-py3.11_x86_64/py3_pystemmer-2.0.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '527430c7925969ab8191dd81a656696c47f074829b385ba41df30f6b6abadae2',
     armv7l: '527430c7925969ab8191dd81a656696c47f074829b385ba41df30f6b6abadae2',
       i686: 'cf1e88389ed6c8b4490a5dfdce773302488821bd870cd3f5de0c395bef313093',
     x86_64: 'c3d75ba58d256841c277712ccc61b497ad67a7299b99633b86259379d8c0e7e7'
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
