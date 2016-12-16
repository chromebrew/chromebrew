require 'package'

class Go < Package
  version '1.7.4'
  source_url 'https://storage.googleapis.com/golang/go1.7.4.src.tar.gz'
  source_sha1 '0fb305c827c8794cfda7e437befa6101a2d06b2e'

  def self.build
    FileUtils.cd('src') do
      system "TMPDIR=/usr/local/tmp ./make.bash"
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
