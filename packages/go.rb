require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.8.3'
  source_url 'https://storage.googleapis.com/golang/go1.8.3.src.tar.gz'
  source_sha1 '7c3b942c58a44396ff1d205d0e6e72770792d626'
  
  # Tests requires perl
  depends_on 'perl'
  # go is required to build versions of go > 1.4
  unless File.exist? "#{CREW_PREFIX}/lib/go/bin/go"
    depends_on 'go_bootstrap'
  end

  def self.build
    FileUtils.cd('src') do
      # install with go_bootstrap if go is not in the path
      unless File.exist? "#{CREW_PREFIX}/lib/go/bin/go"
        system "GOROOT_BOOTSTRAP=#{CREW_PREFIX}/lib/go_bootstrap/go \
                TMPDIR=#{CREW_PREFIX}/tmp \
                ./make.bash"
      else
        system "GOROOT_BOOTSTRAP=#{CREW_PREFIX}/lib/go \
                TMPDIR=#{CREW_PREFIX}/tmp ./make.bash"
      end
    end
  end

  def self.install
    dest = "#{CREW_DEST_DIR}#{CREW_PREFIX}/lib/"
    system "mkdir", "-p", dest
    FileUtils.cp_r Dir.pwd, dest

    puts "--------"
    puts "Installed Go for #{ARCH} in #{CREW_PREFIX}/lib/go"
    puts "Make sure to set go environment variables."
    puts "Minimal:"
    puts "\texport GOROOT=#{CREW_PREFIX}/lib/go"
    puts "\texport PATH=$PATH:$GOROOT/bin"
    puts "To use `go run`:"
    puts "\texport TMPDIR=#{CREW_PREFIX}/tmp"
  end

  def self.check
    FileUtils.cd('src') do
      system "PATH=\"#{Dir.pwd}/../bin:$PATH\" TMPDIR=\"#{CREW_PREFIX}/tmp\" go tool dist test"
    end
  end
end
