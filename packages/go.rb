require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.9.3'
  source_url 'https://dl.google.com/go/go1.9.3.src.tar.gz'
  source_sha256 '4e3d0ad6e91e02efa77d54e86c8b9e34fbe1cbc2935b6d38784dca93331c47ae'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.9.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.9.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.9.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.9.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f7f20bb138834530f44de47829b8b90f9b2240941ec1d38dfd9bde630ffa86be',
     armv7l: 'f7f20bb138834530f44de47829b8b90f9b2240941ec1d38dfd9bde630ffa86be',
       i686: '5b2cd8d31511802ffec769e0539c79ce5053a54c9cac77033fe5eb1925d16fee',
     x86_64: '8bf523281daf9cb8492cb6738433c541fcbf5d67d890ab28a0ca3037aba4bc04',
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
        system "GOROOT_BOOTSTRAP=#{CREW_PREFIX}/lib/go_bootstrap/go \
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

    # make a symbolic link for /usr/local/bin/{go,gofmt}
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
