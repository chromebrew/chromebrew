require 'package'

class Icu4c < Package
  version '58.2'
  source_url 'http://download.icu-project.org/files/icu4c/58.2/icu4c-58_2-src.tgz'
  source_sha1 'b67913c90a484c59fda011797c6f3959d84bdc7c'

  def self.build
    FileUtils.cd('source') do
      system "./configure", "--without-samples", "--without-tests"
      system "make"
    end
  end
  
  def self.install
    FileUtils.cd('source') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end         
end
