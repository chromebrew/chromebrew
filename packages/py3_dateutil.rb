require 'buildsystems/python'

class Py3_dateutil < Python
  description 'Dateutil provides extensions to the standard Python datetime module.'
  homepage 'https://dateutil.readthedocs.io/'
  @_ver = '2.8.2'
  version "#{@_ver}-py3.12"
  license 'BSD-3 and Apache-2.0 or BSD-3'
  compatibility 'all'
  source_url 'https://github.com/dateutil/dateutil.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.2-py3.12_armv7l/py3_dateutil-2.8.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.2-py3.12_armv7l/py3_dateutil-2.8.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.2-py3.12_i686/py3_dateutil-2.8.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.2-py3.12_x86_64/py3_dateutil-2.8.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'aab33e006e88c24a9a27329eaa60cdb902d51fe22e5d32da0e82e0325791449f',
     armv7l: 'aab33e006e88c24a9a27329eaa60cdb902d51fe22e5d32da0e82e0325791449f',
       i686: '9c0f9502226cdf9c8ef077fad9299ec500a4f888abcbd6f901076d59ead159f8',
     x86_64: 'a743bbcc6597bf685529a3f2d06c93a18bdc799c042a753f8ede909316b61066'
  })

  depends_on 'python3' => :build
end
