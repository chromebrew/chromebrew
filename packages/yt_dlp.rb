require 'package'

class Yt_dlp < Package
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  @_ver = '2023.07.06'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yt-dlp/yt-dlp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yt_dlp/2023.07.06-py3.11_armv7l/yt_dlp-2023.07.06-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yt_dlp/2023.07.06-py3.11_armv7l/yt_dlp-2023.07.06-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yt_dlp/2023.07.06-py3.11_i686/yt_dlp-2023.07.06-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yt_dlp/2023.07.06-py3.11_x86_64/yt_dlp-2023.07.06-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '518b918197c1302946822c99dcb1bb7cf2c4e67f5e79c1a364c47c2e5c0a62c7',
     armv7l: '518b918197c1302946822c99dcb1bb7cf2c4e67f5e79c1a364c47c2e5c0a62c7',
       i686: 'b50bcc357b0891aceb519737d320503774bac741e2da5cc488bb53c350069f7c',
     x86_64: '61b3574018e83444bebd251e96250e06166fdaac53dbd3eee1b2f3ee88dee1fd'
  })

  depends_on 'pandoc' => :build
  depends_on 'py3_brotlicffi'
  depends_on 'py3_certifi'
  depends_on 'py3_mutagen'
  depends_on 'py3_pycryptodomex'
  depends_on 'py3_websockets'
  depends_on 'python3'

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "MANDIR=#{CREW_MAN_PREFIX}", 'install'
  end

  def self.postinstall
    puts "\nType 'yt-dlp' to get started.\n".lightblue
  end
end
