require 'buildsystems/python'

class Yt_dlp < Python
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  @_ver = '2023.11.16'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yt-dlp/yt-dlp.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '38eb870583b3d2615d407cc95d14e3a6a0b4475cf6d2efaaa292167575db552d',
     armv7l: '38eb870583b3d2615d407cc95d14e3a6a0b4475cf6d2efaaa292167575db552d',
       i686: 'dfeeb747f3e48d3c9043dbcb04e5766c7c75e21a382b657dffd95188bb774c74',
     x86_64: '71028892a2c9a276012c7fb0d3fc6493b24b878d724831722ec7082753884aa8'
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
