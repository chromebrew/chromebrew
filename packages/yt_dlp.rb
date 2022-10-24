require 'package'

class Yt_dlp < Package
  description 'A fork of youtube-dl with additional features and patches'
  homepage 'https://github.com/yt-dlp/yt-dlp'
  @_ver = '2022.10.04'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yt-dlp/yt-dlp.git'
  git_hashtag @_ver

  depends_on 'py3_brotlicffi'
  depends_on 'py3_certifi'
  depends_on 'py3_mutagen'
  depends_on 'py3_pycryptodomex'
  depends_on 'py3_websockets'
  depends_on 'py3_setuptools' => :build
  depends_on 'pandoc' => :build

  def self.build
    system 'make'
    system 'make', 'completions'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Makefile is screwy
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    FileUtils.mv Dir["#{CREW_DEST_PREFIX}/man/*"], CREW_DEST_MAN_PREFIX
    FileUtils.rm_r "#{CREW_DEST_PREFIX}/man"
  end
end
