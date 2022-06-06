require 'package'

class Youtubedl < Package
  description 'Legacy compatibility package for youtube_dl'
  homepage 'https://youtube-dl.org/'
  @_ver = '2021.12.17'
  version @_ver
  license 'public-domain'
  compatibility 'all'

  is_fake

  depends_on 'youtube_dl'
end
