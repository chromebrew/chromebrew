require 'package'

class Mediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '25.04'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://mediaarea.net/download/binary/mediainfo/#{version}/MediaInfo_CLI_#{version}_GNU_FromSource.tar.xz"
  source_sha256 'ecd286de77cb13ea4b6ce0ebdbbff3f3da89c67ec2d5c330d47f385a4329c5d2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'de0646614be731fa8011661ac2a7277136c4c57508220ba2ebd76d4bad2920e2',
     armv7l: 'de0646614be731fa8011661ac2a7277136c4c57508220ba2ebd76d4bad2920e2',
       i686: '2ed96d3e74442d3445a8c46d0223cdb5bac87fe55f54be5be65fef0157345df4',
     x86_64: '43fd82dc685e1a5955f1302029be5af6eaf5060f1b4ba3caa3d6f276629bedbd'
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
