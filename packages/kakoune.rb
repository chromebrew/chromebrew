require 'package'

class Kakoune < Package
  # TODO prebuild version
  description 'mawww\'s experiment for a better code editor'
  homepage 'http://kakoune.org/'
  compatibility 'all'
  version 'v2018.09.04'
  source_url 'https://github.com/mawww/kakoune/releases/download/v2018.09.04/kakoune-2018.09.04.tar.bz2'
  source_sha256 '7a31c9f08c261c5128d1753762721dd7b7fe4bb4e9a3c368c9d768c72a1472e1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/kakoune-v2018.09.04-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/kakoune-v2018.09.04-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/kakoune-v2018.09.04-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/kakoune-v2018.09.04-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a4304ec155e6c375c841451df07d60b19ed288b0abc9f99b46a6de52a2b40321',
     armv7l: 'a4304ec155e6c375c841451df07d60b19ed288b0abc9f99b46a6de52a2b40321',
       i686: 'd602be65796ba2ec9b13a105910225469e9ba0b73c32459169b1e8ea8784ce13',
     x86_64: 'daed7d68e53f1f2751dc6a9a59c3efaab0a89651ff690b2cb5ac8be02e4d95f1',
  })

  depends_on 'ncurses'  => :build
  depends_on 'asciidoc' => :build
  depends_on 'libxslt'  => :build

  def self.build
    Dir.chdir("src") do
      system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "debug=no"
    end
  end

  def self.install
    Dir.chdir("src") do
      system "make", "install", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "debug=no"
    end
  end
end
