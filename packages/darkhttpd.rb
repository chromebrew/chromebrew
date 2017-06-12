require 'package'

class Darkhttpd < Package
  description 'Minimal webserver written by Emil Mikulic'
  homepage 'https://unix4lyfe.org/darkhttpd/'
  version '1.12'
  source_url 'https://unix4lyfe.org/darkhttpd/darkhttpd-1.12.tar.bz2'
  source_sha1 '30892c4b5d617548410914c9a5e56e0ebce02256'

  def self.build
    system 'make' 
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_DIR}/usr/local/bin"
    FileUtils.cp 'darkhttpd', "#{CREW_DEST_DIR}/usr/local/bin/"
  end
end
