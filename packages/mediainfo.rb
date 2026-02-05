require 'package'

class Mediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '26.01'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://mediaarea.net/download/binary/mediainfo/#{version}/MediaInfo_CLI_#{version}_GNU_FromSource.tar.xz"
  source_sha256 '3e70f27783521c31d6e852bd1982cb8858b9633982b66967a56d5364fb856de3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '000fcaa113229907000108b0a3517dcde430522d6f0adc758723f57985eaa78c',
     armv7l: '000fcaa113229907000108b0a3517dcde430522d6f0adc758723f57985eaa78c',
       i686: '494230bf40c52592be93da5c905f4b24fda4075906cc978f9e2a35e786b5d8a0',
     x86_64: '334d50dcf39783cfebc157e406e128dca3c74da0222552ee98635a422430c02c'
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
