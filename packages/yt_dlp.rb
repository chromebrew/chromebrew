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
    aarch64: '0c4fbbceafefd6c9ddefb57983c3b5517e72aac79830bec41aeb427837c10355',
     armv7l: '0c4fbbceafefd6c9ddefb57983c3b5517e72aac79830bec41aeb427837c10355',
       i686: '671ced7b2a057535356519def850de69a29cdd03f23dfd3de8fefb414852952a',
     x86_64: '3d38238f05f2ec2a8b4ec929c0e7388bcadd91dfaf9a72bf8e6b129465a68f39'
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
