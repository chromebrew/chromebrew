require 'buildsystems/pip'

class Yt_dlp < Pip
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  version "2026.11.23-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '49376e88578d933bdf48da5c7711bdae032d4dcc312b0106ae5d5fe518c3ff79',
     armv7l: '49376e88578d933bdf48da5c7711bdae032d4dcc312b0106ae5d5fe518c3ff79',
       i686: '5d12c917aad3472f9a9b229e2c1864a6c3988afd4f33a204c7f1cd57886c65bd',
     x86_64: '73168aa9c8360e05809f410a188385b4f108dd20c53a214e1a3d1b144d32742d'
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
