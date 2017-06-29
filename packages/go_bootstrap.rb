require 'package'

class Go_bootstrap < Package
  description 'Bootstrap tool chain for the Go programming language.'
  homepage 'https://golang.org/'
  version '1.4'
  source_url 'https://storage.googleapis.com/golang/go1.4-bootstrap-20161024.tar.gz'
  source_sha256 '398c70d9d10541ba9352974cc585c43220b6d8dbcd804ba2c9bd2fbf35fab286'

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
