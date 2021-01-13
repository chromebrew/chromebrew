require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'https://youtube-dl.org/'
  version '2021.01.08'
  compatibility 'all'
  source_url 'https://github.com/ytdl-org/youtube-dl/releases/download/2021.01.08/youtube-dl-2021.01.08.tar.gz'
  source_sha256 '7340448a90ac82dfb2b1b6569f08bd87552b9b1647a81eb735e11dd6d30607cd'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==#{version}"
  end
end
