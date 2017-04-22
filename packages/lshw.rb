require 'package'

class Lshw < Package
  version 'B.02.18' 
  source_url 'http://www.ezix.org/software/files/lshw-B.02.18.tar.gz'
  source_sha1 'c0240f5e53cf40769d52e316719e8010ea6bdea3'

  def self.build
    FileUtils.chdir("src") do
      system "PREFIX=/usr/local make"
    end
  end

  def self.install
    FileUtils.chdir("src") do
      system "PREFIX=/usr/local make DESTDIR=#{CREW_DEST_DIR} install"
    end
  end
end
