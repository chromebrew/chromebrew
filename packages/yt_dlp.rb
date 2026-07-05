require 'buildsystems/pip'

class Yt_dlp < Pip
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  version "2026.7.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '562d4f65032055e821437daf23436797845827435787c6cd8e204d587f9f5d0e',
     armv7l: '562d4f65032055e821437daf23436797845827435787c6cd8e204d587f9f5d0e',
       i686: 'c2516a1e7d2cf45ef89eb0c91f08e9d1434eca40330923beb9c1ab8138178870',
     x86_64: '0ba0cff8caa3935d111597561f937b1531fcb6706bec6a690474fa61a17606f3'
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
