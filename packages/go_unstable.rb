require 'package'

class Go_unstable < Package
  version '1.8rc3'
  source_url 'https://storage.googleapis.com/golang/go1.8rc3.src.tar.gz'
  source_sha1 '7f01a411de18ebe8d078ae81b093926d9d7475f0'
  
  # go is required to build versions of go > 1.4
  if `which go` == ''
    depends_on 'go_bootstrap'
  end

  def self.build
    FileUtils.cd('src') do
      # install with go_bootstrap if go is not in the path
      if `which go` == ''
        system "GOROOT_BOOTSTRAP=/usr/local/lib/go_bootstrap/go \
                TMPDIR=/usr/local/tmp \
                ./make.bash"
      else
        system "TMPDIR=/usr/local/tmp ./make.bash"
      end
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
  end
end
