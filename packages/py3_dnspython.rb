require 'package'

class Py3_dnspython < Package
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  @_ver = '2.1.0'
  version "#{@_ver}-py3.11"
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/rthalley/dnspython.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0-py3.11_armv7l/py3_dnspython-2.1.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0-py3.11_armv7l/py3_dnspython-2.1.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0-py3.11_i686/py3_dnspython-2.1.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0-py3.11_x86_64/py3_dnspython-2.1.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '40ff8964fc89b2dd7af5ff4d10efb5d1cc32dfa559fd50a43c1ad35f95da7417',
     armv7l: '40ff8964fc89b2dd7af5ff4d10efb5d1cc32dfa559fd50a43c1ad35f95da7417',
       i686: '1bc6d84ae1a4ee138b5d827d742555178b924e8b1c73454c339a1224b48a3abb',
     x86_64: '78917859b0b84a94219c826389f13f4f05660a1974b74e970ccdc75985938e35'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
