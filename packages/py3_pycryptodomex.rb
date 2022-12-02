require 'package'

class Py3_pycryptodomex < Package
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  @_ver = '3.11.0'
  version "#{@_ver}-py3.11"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'https://github.com/Legrandin/pycryptodome.git'
  git_hashtag "v#{@_ver}x"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.11.0-py3.11_armv7l/py3_pycryptodomex-3.11.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.11.0-py3.11_armv7l/py3_pycryptodomex-3.11.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.11.0-py3.11_i686/py3_pycryptodomex-3.11.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.11.0-py3.11_x86_64/py3_pycryptodomex-3.11.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ab8fdd14aeb323097b6a5ba1e91a34300f9285c446ada882b9e6f04d1306f8ef',
     armv7l: 'ab8fdd14aeb323097b6a5ba1e91a34300f9285c446ada882b9e6f04d1306f8ef',
       i686: '86f635bfef44d58f2d87535994ccc7f4a173db4fe842adeb2b748fb6e491515d',
     x86_64: '3333e339f97560d6d1ca712ca7f8711d55a34051a2bbd6acdb3617739ea86588'
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
