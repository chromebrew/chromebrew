require 'package'

class Kakoune < Package
  # TODO prebuild version
  description 'mawww\'s experiment for a better code editor'
  homepage 'http://kakoune.org/'
  version 'v2018.09.04'
  source_url 'https://github.com/mawww/kakoune/releases/download/v2018.09.04/kakoune-2018.09.04.tar.bz2'
  source_sha256 '7a31c9f08c261c5128d1753762721dd7b7fe4bb4e9a3c368c9d768c72a1472e1'
  
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
