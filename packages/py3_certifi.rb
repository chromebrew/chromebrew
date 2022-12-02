require 'package'

class Py3_certifi < Package
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/' # 403 Forbidden on 2021.05.08, still 403 Forbidden on 2021.10.13
  @_ver = '2021.10.08'
  version "#{@_ver}-py3.11"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/certifi/python-certifi.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2021.10.08-py3.11_armv7l/py3_certifi-2021.10.08-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2021.10.08-py3.11_armv7l/py3_certifi-2021.10.08-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2021.10.08-py3.11_i686/py3_certifi-2021.10.08-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2021.10.08-py3.11_x86_64/py3_certifi-2021.10.08-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'abca6245b393cc3068268c77540d9bab205c7c124e0b6cda6fa55e7dc570f495',
     armv7l: 'abca6245b393cc3068268c77540d9bab205c7c124e0b6cda6fa55e7dc570f495',
       i686: 'fcb25b8e3aba29b08363ef4bd61f309df750d798ab461d20c7cd548122b2ac62',
     x86_64: 'b7c9747a94f8fab4b51d967291d99bc9b41533ef2db9ba3124c97aadd5ec5d6a'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
