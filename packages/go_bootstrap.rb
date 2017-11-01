require 'package'

class Go_bootstrap < Package
  description 'Bootstrap tool chain for the Go programming language.'
  homepage 'https://golang.org/'
  version '1.4'
  source_url 'https://storage.googleapis.com/golang/go1.4-bootstrap-20161024.tar.gz'
  source_sha256 '398c70d9d10541ba9352974cc585c43220b6d8dbcd804ba2c9bd2fbf35fab286'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/go_bootstrap-1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/go_bootstrap-1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/go_bootstrap-1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/go_bootstrap-1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8156807070467d81cbcc55cd89c499c22e845aae77b5e114fffe595d86819fda',
     armv7l: '8156807070467d81cbcc55cd89c499c22e845aae77b5e114fffe595d86819fda',
       i686: '8f3df69651d3100a7e86161e8c36d9d6a04484247ad3912922044cb3a6f1f0f1',
     x86_64: '16ca50af6bf7b909cab2db4dc2527af782610f081b8717a9f343e81365007a16',
  })

  def self.build
    FileUtils.cd('src') do
      system "TMPDIR=/usr/local/tmp ./make.bash"
    end
  end

  def self.install
    dest = "#{CREW_DEST_DIR}/usr/local/lib/go_bootstrap"
    system "mkdir", "-p", dest
    FileUtils.mv Dir.pwd, dest

    puts "--------"
    puts "Installed Go_bootstrap for #{ARCH} in /usr/local/lib/go_bootstrap"
  end
end
