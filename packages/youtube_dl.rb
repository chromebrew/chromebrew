require 'package'

class Youtube_dl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'https://youtube-dl.org/'
  @_ver = '2021.06.06'
  version @_ver
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/ytdl-org/youtube-dl.git'
  git_hashtag @_ver

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/youtube_dl/2021.06.06_armv7l/youtube_dl-2021.06.06-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/youtube_dl/2021.06.06_armv7l/youtube_dl-2021.06.06-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/youtube_dl/2021.06.06_i686/youtube_dl-2021.06.06-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/youtube_dl/2021.06.06_x86_64/youtube_dl-2021.06.06-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8da245bca7bf4d1b106c5571898efb60c4517e6ad8bbe623c9332d57b19266ad',
     armv7l: '8da245bca7bf4d1b106c5571898efb60c4517e6ad8bbe623c9332d57b19266ad',
       i686: '48f4fa06db554fda1b6b4f6af804204bd4229758ef56bf7cbca2b6fd87039c07',
     x86_64: '41ce42924d1924dd1e7d199f779193e4180d2882361805a41995c0ae6f15c67c',
  })

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
