require 'buildsystems/python'

class Yt_dlp < Python
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  @_ver = '2023.11.16'
  version "#{@_ver}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yt-dlp/yt-dlp.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '88d16c94433eebc091c1ff59aceb6e538efacdcc9328e1744e31a56bb2aa3156',
     armv7l: '88d16c94433eebc091c1ff59aceb6e538efacdcc9328e1744e31a56bb2aa3156',
       i686: 'dfeeb747f3e48d3c9043dbcb04e5766c7c75e21a382b657dffd95188bb774c74',
     x86_64: '2e8e2cbdeb7e557e08e17ecde8e605f2d3e787f043995d4dcfd42ddb5dcccdc9'
  })

  depends_on 'py3_brotlicffi'
  depends_on 'py3_certifi'
  depends_on 'py3_mutagen'
  depends_on 'py3_pycryptodomex'
  depends_on 'py3_websockets'
  depends_on 'python3'

  def self.postinstall
    ExitMessage.add <<~EOF.lightblue
      Type 'yt-dlp' to get started.
    EOF
  end
end
