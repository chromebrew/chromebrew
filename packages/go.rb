require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.8.3-1'
  source_url 'https://storage.googleapis.com/golang/go1.8.3.src.tar.gz'
  source_sha256 '5f5dea2447e7dcfdc50fa6b94c512e58bfba5673c039259fd843f68829d99fa6'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/go-1.8.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/go-1.8.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/go-1.8.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/go-1.8.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f0ed5baa1cc1ec4a393e3255ce5c6556ce29b17395fb660872a7fa7ee9dd7951',
     armv7l: 'f0ed5baa1cc1ec4a393e3255ce5c6556ce29b17395fb660872a7fa7ee9dd7951',
       i686: '5f34ab7487970b560a4eadc37a0308b3e50f9cc37bf5b9c933e8b033c06987c1',
     x86_64: '87bbb19fa513377c1be217dd23897770c3c307fd22bf85e2202de24659b44129',
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
