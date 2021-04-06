require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'https://youtube-dl.org/'
  version '2021.02.10'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/ytdl-org/youtube-dl/releases/download/2021.04.01/youtube-dl-2021.04.01.tar.gz'
  source_sha256 'f098ef95933a33096f60cb8c3bfbde710f6f84c9cad1b093082584bdc4a089ef'

  depends_on 'py3_setuptools' => :build
  
  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
