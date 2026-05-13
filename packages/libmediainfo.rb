require 'package'

class Libmediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '26.05'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://mediaarea.net/download/binary/libmediainfo0/#{version}/MediaInfo_DLL_#{version}_GNU_FromSource.tar.xz"
  source_sha256 'c1ebf9a6b84d0a02d7a0bce63b420273b9459012d64ad57bcf23ec3b26949008'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8bdd695c51d149d5378c66f212ccdda07ee738cf9d095178dc03a506167cb33c',
     armv7l: '8bdd695c51d149d5378c66f212ccdda07ee738cf9d095178dc03a506167cb33c',
       i686: '01ea558574f7dde30d95d0c4316fc108d4eb87bee8f3665bc445d2b34fd50167',
     x86_64: '4641bfa132c5c78704f235172db7a9136205f303f77b665d5eed4676b12d78cd'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "./SO_Compile.sh #{CREW_CONFIGURE_OPTIONS}"
  end

  def self.install
    Dir.chdir 'MediaInfoLib/Project/GNU/Library' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
