require 'package'

class Yt_dlp < Package
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  @_ver = '2023.03.04'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yt-dlp/yt-dlp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yt_dlp/2023.03.04-py3.11_armv7l/yt_dlp-2023.03.04-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yt_dlp/2023.03.04-py3.11_armv7l/yt_dlp-2023.03.04-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yt_dlp/2023.03.04-py3.11_i686/yt_dlp-2023.03.04-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yt_dlp/2023.03.04-py3.11_x86_64/yt_dlp-2023.03.04-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2ae5540262579a43124135e33b9026d8acdcfc9347736d7bbaf5e118fa71589f',
     armv7l: '2ae5540262579a43124135e33b9026d8acdcfc9347736d7bbaf5e118fa71589f',
       i686: 'fd6e22cab07b859ee28e5e47887aa750cf2bab726757cb276c2ccaacb0e34b97',
     x86_64: '630ed8157892c542d237b5cb286e49e7efc0fa237d86f0da6cf6c869c2c31b2a'
  })

  depends_on 'pandoc' => :build
  depends_on 'py3_brotlicffi'
  depends_on 'py3_certifi'
  depends_on 'py3_mutagen'
  depends_on 'py3_pycryptodomex'
  depends_on 'py3_websockets'

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "MANDIR=#{CREW_MAN_PREFIX}", 'install'
  end
end
