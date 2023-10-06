require 'package'

class Yt_dlp < Package
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  @_ver = '2023.09.24'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yt-dlp/yt-dlp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yt_dlp/2023.09.24-py3.12_armv7l/yt_dlp-2023.09.24-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yt_dlp/2023.09.24-py3.12_armv7l/yt_dlp-2023.09.24-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yt_dlp/2023.09.24-py3.12_i686/yt_dlp-2023.09.24-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yt_dlp/2023.09.24-py3.12_x86_64/yt_dlp-2023.09.24-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bfad9e7ad58d6d6c73670c7b9f1dda64d385664e00b49ac97f693ce9fb0b01b2',
     armv7l: 'bfad9e7ad58d6d6c73670c7b9f1dda64d385664e00b49ac97f693ce9fb0b01b2',
       i686: '17e497c4c75f7849fec648b08ae8490fd7a3654269f1f6991d5c4b5387fd0d0f',
     x86_64: 'a35f6f6f3fbe3c3b619f122b056f359f4420d76ff7d5578e8218bbddf9e752a2'
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
