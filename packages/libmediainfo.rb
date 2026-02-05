require 'package'

class Libmediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '26.01'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://mediaarea.net/download/binary/libmediainfo0/#{version}/MediaInfo_DLL_#{version}_GNU_FromSource.tar.xz"
  source_sha256 '860b768d51b7fb58d5935eb96afc4ba8c17883c5e062555d64af3c7146059497'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ce938da0b2f06ee728a53ca9ceb2e3bb2bda4aed6528112c295292845e243c8',
     armv7l: '5ce938da0b2f06ee728a53ca9ceb2e3bb2bda4aed6528112c295292845e243c8',
       i686: '5e0279478cf13b4b4d44b1d90f7c5b56cd1ee3fa5c09fb82eaa4491b6481e8a4',
     x86_64: '5b1663ca97d718fe3dcde25f8fac7a01a804a905bb4f4ef6f9ba9757de2e7766'
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
