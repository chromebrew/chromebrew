require 'package'

class Py3_zipp < Package
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  @_ver = '3.6.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jaraco/zipp.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.6.0-py3.11_armv7l/py3_zipp-3.6.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.6.0-py3.11_armv7l/py3_zipp-3.6.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.6.0-py3.11_i686/py3_zipp-3.6.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_zipp/3.6.0-py3.11_x86_64/py3_zipp-3.6.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '07a970b65be2f3d77c6133c08456521a4bb91bb1c183d406ca63c271dd051922',
     armv7l: '07a970b65be2f3d77c6133c08456521a4bb91bb1c183d406ca63c271dd051922',
       i686: 'd5688b770f2fb7a0e398ae159d0ec250dfc19b7d4c32ce0b5bdc2b9a732add7b',
     x86_64: '0697f9eecf402951133377009b6f3fb1a7129e09f3c0f37981f1b27600b68756'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
