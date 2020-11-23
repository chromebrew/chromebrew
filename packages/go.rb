require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.15.5'
  compatibility 'all'
  source_url 'https://dl.google.com/go/go1.15.5.src.tar.gz'
  source_sha256 'c1076b90cf94b73ebed62a81d802cd84d43d02dea8c07abdc922c57a071c84f1'

  binary_url ({
  })
  binary_sha256 ({
  })

  # Tests require perl
  depends_on 'perl' => :build
  # go is required to build versions of go > 1.4
  unless File.exist? "#{CREW_PREFIX}/share/go/bin/go"
    depends_on 'go_bootstrap' => :build
  end

  def self.build
    FileUtils.cd 'src' do
      ENV['GOROOT'] = '..'
      ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
      ENV['GOROOT_FINAL'] = "#{CREW_PREFIX}/share/go"
      ENV['GOHOSTARCH'] = 'arm' if ARCH == 'aarch64'
      # install with go_bootstrap if go is not in the path
      unless File.exist? "#{CREW_PREFIX}/share/go/bin/go"
        ENV['GOROOT_BOOTSTRAP'] = "#{CREW_PREFIX}/share/go_bootstrap/go"
        ENV['PATH'] = ENV['PATH'] + ":#{CREW_PREFIX}/share/go_bootstrap/go/bin"
      else
        ENV['GOROOT_BOOTSTRAP'] = "#{CREW_PREFIX}/share/go"
      end
      system './make.bash'
    end
  end

  def self.check
    FileUtils.cd 'src' do
      system "PATH=\"#{Dir.pwd}/../bin:$PATH\" GOROOT=\"#{Dir.pwd}/..\" TMPDIR=\"#{CREW_PREFIX}/tmp\" go tool dist test"
    end
  end

  def self.install
    dest = "#{CREW_DEST_PREFIX}/share/"
    FileUtils.mkdir_p dest
    FileUtils.cp_r Dir.pwd, dest

    # make a symbolic link for #{CREW_PREFIX}/bin/{go,gofmt}
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/go/bin/go", "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/go/bin/gofmt", "#{CREW_DEST_PREFIX}/bin"
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
end
