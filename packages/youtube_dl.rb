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

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
