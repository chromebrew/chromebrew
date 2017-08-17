require 'package'

class Darkhttpd < Package
  description 'Minimal webserver written by Emil Mikulic'
  homepage 'https://unix4lyfe.org/darkhttpd/'
  version '1.12'
  source_url 'https://unix4lyfe.org/darkhttpd/darkhttpd-1.12.tar.bz2'
  source_sha256 'a50417b622b32b5f421b3132cb94ebeff04f02c5fb87fba2e31147d23de50505'

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_DIR}/usr/local/bin"
    FileUtils.cp 'darkhttpd', "#{CREW_DEST_DIR}/usr/local/bin/"
  end
end
