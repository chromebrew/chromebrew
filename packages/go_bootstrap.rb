require 'package'

class Go_bootstrap < Package
  version '1.4'
  source_url 'https://storage.googleapis.com/golang/go1.4-bootstrap-20161024.tar.gz'
  source_sha1 '47e02e41aa99dea899b65ebf7b50ec706141be8c'

  def self.build
    FileUtils.cd('src') do
      system "TMPDIR=/usr/local/tmp ./make.bash"
    end
  end

  def self.install
    dest = "#{CREW_DEST_DIR}/usr/local/lib/go_bootstrap"
    system "mkdir", "-p", dest
    FileUtils.mv Dir.pwd, dest
    
    puts "--------"
    puts "Installed Go_bootstrap for #{ARCH} in /usr/local/lib/go_bootstrap"
  end
end