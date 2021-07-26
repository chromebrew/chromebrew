require 'package'

class Youtube_dl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'https://youtube-dl.org/'
  @_ver = '2021.04.26'
  version @_ver
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/ytdl-org/youtube-dl.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/youtube_dl/2021.04.26_armv7l/youtube_dl-2021.04.26-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/youtube_dl/2021.04.26_armv7l/youtube_dl-2021.04.26-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/youtube_dl/2021.04.26_i686/youtube_dl-2021.04.26-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/youtube_dl/2021.04.26_x86_64/youtube_dl-2021.04.26-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2f7b63cb9ddd138426d7e4a9e4407d3f5a55cc7658aa1cfd7bc7ce6b5406aae7',
     armv7l: '2f7b63cb9ddd138426d7e4a9e4407d3f5a55cc7658aa1cfd7bc7ce6b5406aae7',
       i686: '07207b9eec911b3bdd65d448bd6550c47f8fe57869130a93bff67fa5dcc7fcc9',
     x86_64: 'f19905979e9a338c7e1d352dca6e83f6e119d853d67d6ca469db2156c59d9536'
  })

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
