require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.9'
  source_url 'https://storage.googleapis.com/golang/go1.9.src.tar.gz'
  source_sha256 'a4ab229028ed167ba1986825751463605264e44868362ca8e7accc8be057e993'

  binary_url ({
  })
  binary_sha256 ({
  })

  # Tests requires perl
  depends_on 'perl' => :build
  # go is required to build versions of go > 1.4
  unless File.exist? "#{CREW_PREFIX}/lib/go/bin/go"
    depends_on 'go_bootstrap' => :build
  end

  def self.build
    FileUtils.cd('src') do
      # install with go_bootstrap if go is not in the path
      unless File.exist? "#{CREW_PREFIX}/lib/go/bin/go"
        system "GOROOT_BOOTSTRAP=#{CREW_PREFIX}/lib/go_bootstrap/go \
                TMPDIR=#{CREW_PREFIX}/tmp \
                GOROOT_FINAL=#{CREW_PREFIX}/lib/go \
                ./make.bash"
      else
        system "GOROOT_BOOTSTRAP=#{CREW_PREFIX}/lib/go \
                TMPDIR=#{CREW_PREFIX}/tmp \
                GOROOT_FINAL=#{CREW_PREFIX}/lib/go \
                ./make.bash"
      end
    end
  end

  def self.install
    dest = "#{CREW_DEST_DIR}#{CREW_PREFIX}/lib/"
    system "mkdir", "-p", dest
    FileUtils.cp_r Dir.pwd, dest

    # make a symbolic link for /usr/local/bin/{go,gofmt}
    system "mkdir", "-p", "#{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    system "ln", "-s", "#{CREW_PREFIX}/lib/go/bin/go", "#{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    system "ln", "-s", "#{CREW_PREFIX}/lib/go/bin/gofmt", "#{CREW_DEST_DIR}#{CREW_PREFIX}/bin"

    puts "--------"
    puts "Installed Go for #{ARCH} in #{CREW_PREFIX}/lib/go"
    puts ""
    puts "To use `go run`:"
    puts "\texport TMPDIR=#{CREW_PREFIX}/tmp"
    puts ""
    puts "To develop with `go`:"
    puts "\tmkdir -p /usr/local/work/go"
    puts "\tln -s /usr/local/work/go $HOME/go"
    puts "\texport PATH=\"$HOME/go/bin:$PATH\""
    puts "\texport TMPDIR=#{CREW_PREFIX}/tmp"
    puts ""
  end

  def self.check
    FileUtils.cd('src') do
      system "PATH=\"#{Dir.pwd}/../bin:$PATH\" GOROOT=\"#{Dir.pwd}/..\" TMPDIR=\"#{CREW_PREFIX}/tmp\" go tool dist test"
    end
  end
end
