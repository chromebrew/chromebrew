require 'package'

class Go < Package
  version '1.4.1'
  source_url 'https://storage.googleapis.com/golang/go1.4.1.src.tar.gz'
  source_sha1 'c7a683e8d39b835e333199d68d0c0baefcd24a68'

  def self.build
    system "sudo cp -r ../go /usr/local/lib/"
    system "./usr/local/lib/go/all.bash"
  end
  def self.install
    puts "\n---\nCorrected\n---\n"
    puts "Installed Go for linux/amd64 in /usr/local/lib/go"
    puts "Make sure to set go environment variables."
    puts "Minimal:"
    puts "\texport GOROOT=/usr/local/lib/go"
    puts "\texport PATH=$GOROOT/bin"
  end
end
