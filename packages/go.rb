require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  @_ver = '1.16'
  version @_ver
  compatibility 'all'
  source_url "https://dl.google.com/go/go#{@_ver}.src.tar.gz"
  source_sha256 '7688063d55656105898f323d90a79a39c378d86fe89ae192eb3b7fc46347c95a'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.16-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5c8a7c1dba8d2d58cf474e6d0dfbe0d327268b3795fa6d59c84cf7e578c890e5',
     armv7l: '5c8a7c1dba8d2d58cf474e6d0dfbe0d327268b3795fa6d59c84cf7e578c890e5',
       i686: 'c1e8ef3998c06c069e49703af7f8c8bc719dcbd3c488322d9b3c3db765ee4dc8',
     x86_64: '163773e1e201b0829189724b6781c6aa8e78eccf2041aa3cb09f07d7bc44e777'
  })

  @env ||= ''

  # Tests require perl
  # go is required to build versions of go > 1.4
  case ARCH
  when 'x86_64'
    @go_bootstrap_url = "https://golang.org/dl/go#{@_ver}.linux-amd64.tar.gz"
  when 'i686'
    @go_bootstrap_url = "https://golang.org/dl/go#{@_ver}.linux-386.tar.gz"
  when 'aarch64', 'armv7l'
    unless File.exist? "#{CREW_PREFIX}/share/go/bin/go"
      depends_on 'go_bootstrap' => :build
      @env += " PATH=$PATH:#{CREW_PREFIX}/share/go_bootstrap/go/bin"
    end
  end

  def self.build
    # Binaries not available for armv7l, so build those.
    case ARCH
    when 'aarch64', 'armv7l'
      FileUtils.cd 'src' do
        @env += "GOROOT='..'"
        @env += " TMPDIR=#{CREW_PREFIX}/tmp"
        @env += " GOROOT_FINAL=#{CREW_PREFIX}/share/go"
        @env += ' GOHOSTARCH=arm' if ARCH == 'aarch64'
        # install with go_bootstrap if go is not in the path
        if File.exist? "#{CREW_PREFIX}/share/go/bin/go"
          @env += " GOROOT_BOOTSTRAP=#{CREW_PREFIX}/share/go"
        else
          @env += " GOROOT_BOOTSTRAP=#{CREW_PREFIX}/share/go_bootstrap/go"
          @env += " PATH=$PATH:#{CREW_PREFIX}/share/go_bootstrap/go/bin"
        end
        system "env #{@env} ./make.bash"
      end
    end
  end

  def self.check
    case ARCH
    when 'aarch64', 'armv7l'
      Dir.chdir 'src' do
        system "PATH=\"#{Dir.pwd}/../bin:$PATH\" GOROOT=\"#{Dir.pwd}/..\" TMPDIR=\"#{CREW_PREFIX}/tmp\" go tool dist test"
      end
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    case ARCH
    when 'i686', 'x86_64'
      system "curl -Ls #{@go_bootstrap_url} | tar -C #{CREW_DEST_PREFIX}/share/ -zxf -"
    when 'aarch64', 'armv7l'
      FileUtils.cp_r Dir.pwd, "#{CREW_DEST_PREFIX}/share/"
    end

    # make a symbolic link for #{CREW_PREFIX}/bin/{go,gofmt}
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/go/bin/go", "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/go/bin/gofmt", "#{CREW_DEST_PREFIX}/bin"
  end

  def self.postinstall
    puts
    puts "Installed Go for #{ARCH} in #{CREW_PREFIX}/share/go".lightblue
    puts
    puts 'To use `go run`, execute the following:'.lightblue
    puts "export TMPDIR=#{CREW_PREFIX}/tmp".lightblue
    puts
    puts 'To develop with `go`, execute the following:'.lightblue
    puts "mkdir -p #{CREW_PREFIX}/work/go".lightblue
    puts "ln -s #{CREW_PREFIX}/work/go $HOME/go".lightblue
    puts 'export PATH="$HOME/go/bin:$PATH"'.lightblue
    puts "export TMPDIR=#{CREW_PREFIX}/tmp".lightblue
    puts
  end
end
