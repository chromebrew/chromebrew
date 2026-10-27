require 'buildsystems/pip'

class Yt_dlp < Pip
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  version "2026.10.26-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00272f5d804794c11510680dfb84e52141face7a5b3c9d11bfa983ea7a46186b',
     armv7l: '00272f5d804794c11510680dfb84e52141face7a5b3c9d11bfa983ea7a46186b',
       i686: '20f6c3747969c4cb003b68c29b36971be46e59abac980151e51d8efd044d9b17',
     x86_64: 'b9f673317c40f82cab5928e82c8c4838d7f152078924b876a703fcc87fbb22a8'
  })

  depends_on 'py3_brotlicffi'
  depends_on 'py3_certifi'
  depends_on 'py3_hatchling'
  depends_on 'py3_mutagen'
  depends_on 'py3_pycryptodomex'
  depends_on 'py3_websockets'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build

  def self.postinstall
    ExitMessage.add "\nType 'yt-dlp' to get started.\n"
  end
end
