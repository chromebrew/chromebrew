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
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '96098548192acc150e8894cdc7bdc96c29f6cab9b1fa6452112b5fc4c80e4230',
     armv7l: '96098548192acc150e8894cdc7bdc96c29f6cab9b1fa6452112b5fc4c80e4230',
       i686: '458688a4eaa94c2e260032589e6d97d58839594c2c0c3fa06042321985c14892',
     x86_64: '6e7503a815f3965b5a90b95742ccdf2000d765876e721aa17c205dc3a10a7fcf'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build
end
