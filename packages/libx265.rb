require 'package'

class Libx265 < Package
  description 'x265 is a H.265 / HEVC video encoder application library.'
  homepage 'http://x265.org/'
  version '2.4'
  source_url 'https://bitbucket.org/multicoreware/x265/downloads/x265_2.4.tar.gz'
  source_sha256 '9c2aa718d78f6fecdd783f08ab83b98d3169e5f670404da4c16439306907d729'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libx265-2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libx265-2.4-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libx265-2.4-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libx265-2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '719327b0fa7b551025d09b99add81b217ad5a34798504f4a705d73406741a77a',
     armv7l: '719327b0fa7b551025d09b99add81b217ad5a34798504f4a705d73406741a77a',
       i686: 'ae22b9c37a522bc2edaca35d09777daed05566cd44d82199112cdd7250a95fab',
     x86_64: 'a5579d3806098783677b2a7f71dea95137f1b676f6347861431a1664d5ae0633',
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
