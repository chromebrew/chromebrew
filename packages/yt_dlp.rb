require 'buildsystems/python'

class Yt_dlp < Python
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  version "2025.06.30-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yt-dlp/yt-dlp.git'
  git_hashtag version.split('-')[0]

  depends_on 'py3_brotlicffi'
  depends_on 'py3_certifi'
  depends_on 'py3_hatchling'
  depends_on 'py3_mutagen'
  depends_on 'py3_pycryptodomex'
  depends_on 'py3_websockets'
  depends_on 'python3'

  no_compile_needed

  def self.postinstall
    ExitMessage.add "\nType 'yt-dlp' to get started.\n"
  end
end
