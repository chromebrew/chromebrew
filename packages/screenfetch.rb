require 'package'

class Screenfetch < Package
  description 'Fetches system/theme information in terminal for Linux desktop screenshots.'
  homepage 'https://github.com/KittyKatt/screenFetch'
  version '3.9.9'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/KittyKatt/screenFetch.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af5e7e3afbb1190fac4f190f87ee1f0ba7ea491ccc82b4f60399a9e667d5c9b2',
     armv7l: 'af5e7e3afbb1190fac4f190f87ee1f0ba7ea491ccc82b4f60399a9e667d5c9b2',
       i686: '7980f9f1bd43f09b3f7c85b81d13e2fb7bbabe1d0efe3190c4511a8eb5bf1cd9',
     x86_64: '30d5f73c089280952a8591a23cb1fd4c34b5d0c0ea14eb81edbe25aba849a641'
  })

  depends_on 'bc'

  def self.install
    FileUtils.install 'screenfetch-dev', "#{CREW_DEST_PREFIX}/bin/screenfetch", mode: 0o755
    FileUtils.install 'screenfetch.1', "#{CREW_DEST_MAN_PREFIX}/man1/screenfetch.1", mode: 0o644
  end
end
