require 'package'

class Mediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'http://mediaarea.net/en/MediaInfo'
  version '24.04'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://mediaarea.net/download/binary/mediainfo/24.04/MediaInfo_CLI_24.04_GNU_FromSource.tar.xz'
  source_sha256 'bb5bae69a9067f76250976cd1a6fadde110cf9bfb4dea7e18070f0f08cf23eb8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3fa699cb3ef87f24fcd94401b4811d52a176c8abd721be5ac4432e40efa32f4',
     armv7l: 'a3fa699cb3ef87f24fcd94401b4811d52a176c8abd721be5ac4432e40efa32f4',
       i686: '48a637c6095d6fb5843078e4c7da412e855c517965753e3f77a68763ed9c8f9d',
     x86_64: '9a761f66c3e2f8f7f8728cf2adba442b6ee62182c3037b49abbd4af489855bec'
  })

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "mold -run ./CLI_Compile.sh #{CREW_OPTIONS}"
  end

  def self.install
    Dir.chdir 'MediaInfo/Project/GNU/CLI' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
