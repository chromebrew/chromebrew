require 'package'

class Ffmpeg_thumbnailer < Package
  description 'Lightweight video thumbnailer. https://github.com/dirkvdb/ffmpegthumbnailer'
  homepage 'https://github.com/dirkvdb/ffmpegthumbnailer/releases'
  version '2.2.0'
  source_url 'https://github.com/dirkvdb/ffmpegthumbnailer/archive/2.2.0.tar.gz'
  source_sha256 '8bc74755aa960531acdea8fa19ad7e1b7c806c28a068306a8c7150d278241a8f'

  depends_on 'ffmpeg'
  depends_on 'libpng'

  def self.build
    system "cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_GIO=ON -DENABLE_THUMBNAILER=ON ."
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
