require 'package'

class Go < Package
  version '1.6.2'
  source_url 'https://storage.googleapis.com/golang/go1.6.2.src.tar.gz'
  source_sha1 '09232AC0E76635CC9E0A1F33A81BF03AE9CB9DB5'

  def self.build
    FileUtils.cd('src') do
      system "./all.bash"
    end
  end

  def self.install
    dest = "#{CREW_DEST_DIR}/usr/local/lib/"
    system "mkdir", "-p", dest
    FileUtils.mv Dir.pwd, dest

    puts "--------"
    puts "Installed Go for linux/amd64 in /usr/local/lib/go"
    puts "Make sure to set go environment variables."
    puts "Minimal:"
    puts "\texport GOROOT=/usr/local/lib/go"
    puts "\texport PATH=$GOROOT/bin"
  end
end
