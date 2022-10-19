require 'package'

class Yt_dlp < Package
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
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
    FileUtils.mv "#{CREW_DEST_PREFIX}/man" "#{CREW_DEST_MAN_PREFIX}"
  end
end
