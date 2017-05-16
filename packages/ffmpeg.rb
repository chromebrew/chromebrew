require 'package'

class Ffmpeg < Package
  version '3.3'
  source_url 'https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz'
  source_sha1 '93e395ea0a65e25ecf839c5937b9856d49677efe'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp ffmpeg #{CREW_DEST_DIR}/usr/local/bin"
    system "cp ffprobe #{CREW_DEST_DIR}/usr/local/bin"
  end
end
