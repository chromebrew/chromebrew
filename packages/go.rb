require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  @_ver = '1.16.3'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url "https://dl.google.com/go/go#{@_ver}.src.tar.gz"
  source_sha256 'b298d29de9236ca47a023e382313bcc2d2eed31dfa706b60a04103ce83a71a25'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.16.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.16.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.16.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.16.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2f6ab6029594d5563bd1b020ff0982d960a8d569e0081d1a36f4972a436e2e1b',
     armv7l: '2f6ab6029594d5563bd1b020ff0982d960a8d569e0081d1a36f4972a436e2e1b',
       i686: '13df993fe2af5ab01b1d4f28808dab883107ad62fb4dd566970b52d1decd26aa',
     x86_64: 'f4676ad5ab1f1c83e73e4dfd1b94794a7630e9d1880e854ea81da9ffe912cd8f'
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
        system "PATH=\"#{Dir.pwd}/../bin:$PATH\" GOROOT=\"#{Dir.pwd}/..\" go tool dist test"
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

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @gorun = <<~EOF
      # Uncomment the line starting with "export" below to use `go run`
      # Don't forget to uncomment it when you're done
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/go-run", @gorun)
    @godev = <<~EOF
      # Go development configuration
      if [ ! -e #{CREW_PREFIX}/work/go ]; then
        mkdir -vp #{CREW_PREFIX}/work/go
      fi
      if [ ! -e #{HOME}/go ]; then
        ln -sv #{CREW_PREFIX}/work/go #{HOME}/go
      fi
      export PATH="$PATH:$HOME/go/bin"
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/go-dev", @godev)
  end

  def self.postinstall
    puts
    puts "Edit #{CREW_PREFIX}/etc/env.d/go-run to be able to use go-run".lightblue
    puts
  end
end
