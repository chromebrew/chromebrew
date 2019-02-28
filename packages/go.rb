require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.12'
  source_url 'https://dl.google.com/go/go1.12.src.tar.gz'
  source_sha256 '09c43d3336743866f2985f566db0520b36f4992aea2b4b2fd9f52f17049e88f2'

  binary_url ({
  })
  binary_sha256 ({
  })

  # Tests requires perl
  depends_on 'perl' => :build
  # go is required to build versions of go > 1.4
  unless File.exist? "#{CREW_PREFIX}/share/go/bin/go"
    depends_on 'go_bootstrap' => :build
  end

  def self.build
    FileUtils.cd('src') do
      # install with go_bootstrap if go is not in the path
      unless File.exist? "#{CREW_PREFIX}/share/go/bin/go"
        system "GOROOT_BOOTSTRAP=#{CREW_PREFIX}/share/go_bootstrap/go \
                TMPDIR=#{CREW_PREFIX}/tmp \
                GOROOT_FINAL=#{CREW_PREFIX}/share/go \
                ./make.bash"
      else
        system "GOROOT_BOOTSTRAP=#{CREW_PREFIX}/share/go \
                TMPDIR=#{CREW_PREFIX}/tmp \
                GOROOT_FINAL=#{CREW_PREFIX}/share/go \
                ./make.bash"
      end
    end
  end

  def self.install
    dest = "#{CREW_DEST_PREFIX}/share/"
    system "mkdir", "-p", dest
    FileUtils.cp_r Dir.pwd, dest

    # make a symbolic link for #{CREW_PREFIX}/bin/{go,gofmt}
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/bin"
    system "ln", "-s", "#{CREW_PREFIX}/share/go/bin/go", "#{CREW_DEST_PREFIX}/bin"
    system "ln", "-s", "#{CREW_PREFIX}/share/go/bin/gofmt", "#{CREW_DEST_PREFIX}/bin"
  end

  def self.postinstall
    puts
    puts "Installed Go for #{ARCH} in #{CREW_PREFIX}/share/go".lightblue
    puts
    puts "To use `go run`, execute the following:".lightblue
    puts "export TMPDIR=#{CREW_PREFIX}/tmp".lightblue
    puts
    puts "To develop with `go`, execute the following:".lightblue
    puts "mkdir -p #{CREW_PREFIX}/work/go".lightblue
    puts "ln -s #{CREW_PREFIX}/work/go $HOME/go".lightblue
    puts "export PATH=\"$HOME/go/bin:$PATH\"".lightblue
    puts "export TMPDIR=#{CREW_PREFIX}/tmp".lightblue
    puts
  end

  def self.check
    FileUtils.cd('src') do
      system "PATH=\"#{Dir.pwd}/../bin:$PATH\" GOROOT=\"#{Dir.pwd}/..\" TMPDIR=\"#{CREW_PREFIX}/tmp\" go tool dist test"
    end
  end
end
