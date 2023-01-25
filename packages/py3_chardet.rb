require 'package'

class Py3_chardet < Package
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  @_ver = '4.0.0'
  version "#{@_ver}-py3.11"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/chardet/chardet.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_chardet/4.0.0-py3.11_armv7l/py3_chardet-4.0.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_chardet/4.0.0-py3.11_armv7l/py3_chardet-4.0.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_chardet/4.0.0-py3.11_i686/py3_chardet-4.0.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_chardet/4.0.0-py3.11_x86_64/py3_chardet-4.0.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e9a503a9cb01393a51871d6d504c27a7e74d5560a36f758e743c38407e736301',
     armv7l: 'e9a503a9cb01393a51871d6d504c27a7e74d5560a36f758e743c38407e736301',
       i686: 'de56e5463d15c0ac8efd4fe43c2fa9b92eede85db8267d5cf286a7feed76ab68',
     x86_64: '3bcfb7009c40cd73c2e6ec803f4dd2cd4b9592bdb41a024fa192e8d963ad54ab'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
