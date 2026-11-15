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
    aarch64: '66f90cda923f192777f581c8f15fcf59739330c784ae854e9d03cd27b8a7f33b',
     armv7l: '66f90cda923f192777f581c8f15fcf59739330c784ae854e9d03cd27b8a7f33b',
       i686: '53b21ea4021d296764ed19862e385a87cb49199e73a763f90653fe9ceda9210d',
     x86_64: 'f130ed67734fec0cfbffd4ca90b4c1c99e883f23f0381aca79b044127c7d1fcb'
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
