require 'package'

class Go < Package
  version '1.7.5'
  source_url 'https://storage.googleapis.com/golang/go1.7.5.src.tar.gz'
  source_sha1 '4a36ad56b11579a8d534817b70a9baf754e5369a'
  
  # go > 1.4 requirs go_bootstrap
  depends_on 'go_bootstrap'

  def self.build
    FileUtils.cd('src') do
      # Install with go_bootstrap.  Use make.bash instead of all.bash to
      # skip test since it fails as explained in #265.
      system "GOROOT_BOOTSTRAP=/usr/local/lib/go_bootstrap/go \
              TMPDIR=/usr/local/tmp \
              ./make.bash"
    end
  end

  def self.install
    dest = "#{CREW_DEST_DIR}/usr/local/lib/"
    system "mkdir", "-p", dest
    FileUtils.mv Dir.pwd, dest

    puts "--------"
    puts "Installed Go for #{ARCH} in /usr/local/lib/go"
    puts "Make sure to set go environment variables."
    puts "Minimal:"
    puts "\texport GOROOT=/usr/local/lib/go"
    puts "\texport PATH=$PATH:$GOROOT/bin"
    puts "To use `go run`:"
    puts "\texport TMPDIR=/usr/local/tmp"
  end
end
