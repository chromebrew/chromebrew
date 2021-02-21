require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'https://youtube-dl.org/'
  version '2021.02.10'
  compatibility 'all'
  source_url 'https://github.com/ytdl-org/youtube-dl/releases/download/2021.02.10/youtube-dl-2021.02.10.tar.gz'
  source_sha256 'd607adf66b7047865733f7d05af9478118ee4dd974ef9f971563e11de7f29122'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==#{version} --no-warn-script-location"
  end
end
