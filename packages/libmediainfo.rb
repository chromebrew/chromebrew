require 'package'

class Libmediainfo < Package
  description 'MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.'
  homepage 'https://mediaarea.net/en/MediaInfo'
  version '25.07'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://mediaarea.net/download/binary/libmediainfo0/#{version}/MediaInfo_DLL_#{version}_GNU_FromSource.tar.xz"
  source_sha256 'cbcc46a661d03904795b5f55a7eeb98c0210e8887e89e3efc0c6c415d236f276'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd19130288ee2e5d159e05aefdb49d39d81cf489d50775ff7b4145158dad9913',
     armv7l: 'fd19130288ee2e5d159e05aefdb49d39d81cf489d50775ff7b4145158dad9913',
       i686: '6ec2f166519f77cce83c44696ddac51a823538fd94393a0bdd2622fa50105d5a',
     x86_64: 'b5514a30eef8332a533ed1dc3ff918f05b76a5c4dec02ad4145b51fb30d7e62a'
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
