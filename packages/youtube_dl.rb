require 'package'

class Youtube_dl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'https://youtube-dl.org/'
  @_ver = '2021.06.06'
  version "#{@_ver}-1"
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/ytdl-org/youtube-dl.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/youtube_dl/2021.06.06-1_armv7l/youtube_dl-2021.06.06-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/youtube_dl/2021.06.06-1_armv7l/youtube_dl-2021.06.06-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/youtube_dl/2021.06.06-1_i686/youtube_dl-2021.06.06-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/youtube_dl/2021.06.06-1_x86_64/youtube_dl-2021.06.06-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4ed1f09c314bdc024df635dc785bba85933cd7781e6d6b6afbc1d4aef9123671',
     armv7l: '4ed1f09c314bdc024df635dc785bba85933cd7781e6d6b6afbc1d4aef9123671',
       i686: '0a22a05e40e851363b4f72614785db19a19a66d638ad04b937abc15f3e7081c6',
     x86_64: 'f2d75d96cce08dff64f1fb9aeef7a5190b7c3bdcac8facd45d1b938eba57ab22'
  })

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
