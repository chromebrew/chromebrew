require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  @_ver = '1.19.2'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url "https://dl.google.com/go/go#{@_ver}.src.tar.gz"
  source_sha256 '2ce930d70a931de660fdaf271d70192793b1b240272645bf0275779f6704df6b'

  @env ||= ''

  depends_on 'perl' => :build # Tests require perl

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
    # case ARCH
    # when 'aarch64', 'armv7l'
    # Dir.chdir 'src' do
    # Currently fails with TestGdbPythonCgo
    # Reported upstream at https://github.com/golang/go/issues/51694
    # system "PATH=\"#{Dir.pwd}/../bin:$PATH\" GOROOT=\"#{Dir.pwd}/..\" go tool dist test || true"
    # end
    # end
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
    @gorun = <<~GORUN_EOF
      # Uncomment the line starting with "export" below to use `go run`
      # Don't forget to uncomment it when you're done
    GORUN_EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/go-run", @gorun)
    @godev = <<~GODEV_EOF
      # Go development configuration
      if [ ! -e #{CREW_PREFIX}/work/go ]; then
        mkdir -vp #{CREW_PREFIX}/work/go
      fi
      if [ ! -e #{HOME}/go ]; then
        # This check is not working so force symlink, otherwise we get
        # an error at every shell invocation.
        ln -fsv #{CREW_PREFIX}/work/go #{HOME}/go
      fi
      export PATH="$PATH:$HOME/go/bin"
    GODEV_EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/go-dev", @godev)
  end

  def self.postinstall
    puts
    puts "Edit #{CREW_PREFIX}/etc/env.d/go-run to be able to use go-run".lightblue
    puts
  end
end
