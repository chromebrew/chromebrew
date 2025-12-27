require 'buildsystems/pip'

class Yt_dlp < Pip
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  version "2025.11.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e51b131e5c54b1e445da5f9f528e330fdd5b2c54c8f839babb32bd5e0b3d36c8',
     armv7l: 'e51b131e5c54b1e445da5f9f528e330fdd5b2c54c8f839babb32bd5e0b3d36c8',
       i686: '47cb25af751409b7844fbbecd39aefedd5e6a17c5b234fdbb4c28f83f4b5c76e',
     x86_64: 'ae9def42d7c756e6b4cfc134a3ee9b9ff762f2dd52f67779bd096f1b01a7670a'
  })

  depends_on 'py3_brotlicffi'
  depends_on 'py3_certifi'
  depends_on 'py3_hatchling'
  depends_on 'py3_mutagen'
  depends_on 'py3_pycryptodomex'
  depends_on 'py3_websockets'
  depends_on 'python3'

  no_source_build

  def self.postinstall
    ExitMessage.add "\nType 'yt-dlp' to get started.\n"
  end
end
