require 'package'

class Py3_isodate < Package
  description 'ISOdate is an ISO 8601 date/time/duration parser and formatter.'
  homepage 'https://github.com/gweis/isodate/'
  @_ver = '0.6.0'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/gweis/isodate.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0-py3.11_armv7l/py3_isodate-0.6.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0-py3.11_armv7l/py3_isodate-0.6.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0-py3.11_i686/py3_isodate-0.6.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0-py3.11_x86_64/py3_isodate-0.6.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '89339b3856d66d25d1cb8ff855cbf715dbc2df3fe98890582b150c737f97db60',
     armv7l: '89339b3856d66d25d1cb8ff855cbf715dbc2df3fe98890582b150c737f97db60',
       i686: '8a7e9d140638e763bf0b973ff4c8c84f7c8d9644d70a4c4001467dbe9f36d595',
     x86_64: 'aaa274b193e379799a71772c99d3c3f10377b621822715dad38d98569106ad97'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
