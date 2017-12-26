require 'package'

class Libx265 < Package
  description 'x265 is a H.265 / HEVC video encoder application library.'
  homepage 'http://x265.org/'
  version '2.6'
  source_url 'https://bitbucket.org/multicoreware/x265/downloads/x265_2.6.tar.gz'
  source_sha256 '1bf0036415996af841884802161065b9e6be74f5f6808ac04831363e2549cdbf'

  binary_url ({
  })
  binary_sha256 ({
  })

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
