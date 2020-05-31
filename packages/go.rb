require 'package'

class Go < Package
  description 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.'
  homepage 'https://golang.org/'
  version '1.14.2'
  source_url 'https://dl.google.com/go/go1.14.2.src.tar.gz'
  source_sha256 '98de84e69726a66da7b4e58eac41b99cbe274d7e8906eeb8a5b7eb0aadee7f7c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.14.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.14.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.14.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/go-1.14.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6370b16b60d922b2809ee02daa50001389d8a140e8d9205d78dea1051dd5862b',
     armv7l: '6370b16b60d922b2809ee02daa50001389d8a140e8d9205d78dea1051dd5862b',
       i686: 'c924075cfa74fd1055a9bca62308f131d522ae527eac082dc33ba95b7db2d23e',
     x86_64: '8c6d89a1a321fc0e89d5a200cedec07145ffece37c0d42c8859c550b7bbef65d',
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
