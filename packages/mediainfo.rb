require 'package'

class Mediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '25.10'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://mediaarea.net/download/binary/mediainfo/#{version}/MediaInfo_CLI_#{version}_GNU_FromSource.tar.xz"
  source_sha256 '9a7743562053d619dcfd0cdafe71eadd6c36b134649d378a4c5c8d074ace42b5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa34ae3825326db3e645c9ac3ce99c0a98e7f3d5ecf89ba12c9a100d24aaccc7',
     armv7l: 'aa34ae3825326db3e645c9ac3ce99c0a98e7f3d5ecf89ba12c9a100d24aaccc7',
       i686: '6755edc5c6ed4790c3a11dfa73e03dc62c970f5972a06547c5aaf34879392226',
     x86_64: '532495e2b5d746eea8cd59ecd9125f58c5eea13776546fda1ced704708d5b9b0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "./CLI_Compile.sh #{CREW_CONFIGURE_OPTIONS}"
  end

  def self.install
    Dir.chdir 'MediaInfo/Project/GNU/CLI' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
