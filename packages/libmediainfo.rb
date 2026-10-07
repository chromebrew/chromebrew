require 'package'

class Libmediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '26.10'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://mediaarea.net/download/binary/libmediainfo0/#{version}/MediaInfo_DLL_#{version}_GNU_FromSource.tar.xz"
  source_sha256 '8bd0c3819412d0dd7a3cafaf8bcf87f393028b60c27d6c2ef0f56f0eb2a11229'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7fcb5bce50a408c250936e7fd25b8fed6da221a50c18aafb757e7f96f90cf1ce',
     armv7l: '7fcb5bce50a408c250936e7fd25b8fed6da221a50c18aafb757e7f96f90cf1ce',
       i686: '8cc4ccf0e827e648c5010bb7646e63ad23785fe2f596f2e01762e277bea7dad2',
     x86_64: 'f2a497f6b9f8a8fda081f1a4aa19e3d3c5e77a380fbb967a33e147b8caad7fd7'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :library

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
