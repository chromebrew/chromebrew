require 'buildsystems/pip'

class Yt_dlp < Pip
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  version "2026.3.17-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd5ed897bca4e487791c1b2cb75ac538b7dabfcba1135bd7d658727a9088d52b',
     armv7l: 'cd5ed897bca4e487791c1b2cb75ac538b7dabfcba1135bd7d658727a9088d52b',
       i686: '6df4622e6932f5cbc27427e03b7daa932d42afb1fde8c6f47055a70f75b07573',
     x86_64: '2a7921b37524d455efdb4fd3366e808c6005b3ebf0fe1dde90a04dd71909ec90'
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
