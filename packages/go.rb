require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.15.5'
  compatibility 'all'
  source_url 'https://dl.google.com/go/go1.15.5.src.tar.gz'
  source_sha256 'c1076b90cf94b73ebed62a81d802cd84d43d02dea8c07abdc922c57a071c84f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.15.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.15.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.15.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.15.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '272f22f883fc7215ae6d5fb5edfa77b0d7b569fe4505ca7d7cf02ad0b594ebeb',
     armv7l: '272f22f883fc7215ae6d5fb5edfa77b0d7b569fe4505ca7d7cf02ad0b594ebeb',
       i686: 'd93951d4ba4c9dc07ed89db5eaa7f62b9e60d70c49712c5cc24a8debe28fb66c',
     x86_64: '228376a806cec3c5ddc6e4276fabfcd1bc002d57f84dd2124d49bf2c0907ddfa',
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
