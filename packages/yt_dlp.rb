require 'buildsystems/pip'

class Yt_dlp < Pip
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  version "2026.8.19-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df46254fbab640c102857dd0cd93d50d160b9a39a74351548700647f76207c46',
     armv7l: 'df46254fbab640c102857dd0cd93d50d160b9a39a74351548700647f76207c46',
       i686: '4fdc75da22f1e52f7460c0468c36f806bb46ca4dabc96b389b5ac1c59ef819f2',
     x86_64: 'f500d13b4ac98053c0787037a668b381d0dc82dadc81ae470799e272f0c0fd61'
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
