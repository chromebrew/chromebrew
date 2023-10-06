require 'buildsystems/python'

class Py3_isodate < Python
  description 'ISOdate is an ISO 8601 date/time/duration parser and formatter.'
  homepage 'https://github.com/gweis/isodate/'
  @_ver = '0.6.1'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/gweis/isodate.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.1-py3.12_armv7l/py3_isodate-0.6.1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.1-py3.12_armv7l/py3_isodate-0.6.1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.1-py3.12_i686/py3_isodate-0.6.1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.1-py3.12_x86_64/py3_isodate-0.6.1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '96098548192acc150e8894cdc7bdc96c29f6cab9b1fa6452112b5fc4c80e4230',
     armv7l: '96098548192acc150e8894cdc7bdc96c29f6cab9b1fa6452112b5fc4c80e4230',
       i686: '458688a4eaa94c2e260032589e6d97d58839594c2c0c3fa06042321985c14892',
     x86_64: '6e7503a815f3965b5a90b95742ccdf2000d765876e721aa17c205dc3a10a7fcf'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build
end
