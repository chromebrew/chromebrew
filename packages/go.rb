require 'package'

class Go < Package
  version '1.7.4'
  source_url 'https://storage.googleapis.com/golang/go1.7.4.src.tar.gz'
  source_sha1 '0fb305c827c8794cfda7e437befa6101a2d06b2e'
  
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
