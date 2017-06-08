require 'package'

class Libx265 < Package
  description 'x265 is a H.265 / HEVC video encoder application library.'
  homepage 'http://x265.org/'
  version '2.4'
  source_url 'https://bitbucket.org/multicoreware/x265/downloads/x265_2.4.tar.gz'
  source_sha1 'f8bfb348defa86fbfdce4dcc1d0c48c855e0e987'

  depends_on 'cmake'
  depends_on 'yasm'

  def self.build
    FileUtils.cd('source') do
      system "cmake ."
      system "make"
    end
  end

  def self.install
    FileUtils.cd('source') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
