require 'package'

class Go_bootstrap < Package
  description 'Bootstrap tool chain for the Go programming language.'
  homepage 'https://golang.org/'
  version '1.4-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://dl.google.com/go/go1.4-bootstrap-20171003.tar.gz'
  source_sha256 'f4ff5b5eb3a3cae1c993723f3eab519c5bae18866b5e5f96fe1102f0cb5c3e52'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_bootstrap/1.4-1_armv7l/go_bootstrap-1.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_bootstrap/1.4-1_armv7l/go_bootstrap-1.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_bootstrap/1.4-1_i686/go_bootstrap-1.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_bootstrap/1.4-1_x86_64/go_bootstrap-1.4-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'dd2aaa41eb1e27a50d9a805f0bbe4b0924bb2fd4ddeccbe2658fb7fd59f48956',
     armv7l: 'dd2aaa41eb1e27a50d9a805f0bbe4b0924bb2fd4ddeccbe2658fb7fd59f48956',
       i686: '661fb3c1c1fcebf6a00014e9e1074ee34ca5e60cbdde669b6a49c6931df5e034',
     x86_64: 'd4a4c1fd6289e2fdbf031ed1da28f21b0f6e58f16e614f248f84f6fabab0555c'
  })

  def self.build
    FileUtils.cd('src') do
      system './make.bash'
    end
  end

  def self.install
    dest = "#{CREW_DEST_PREFIX}/share/go_bootstrap"
    system 'mkdir', '-p', dest
    FileUtils.mv Dir.pwd, dest

    puts '--------'
    puts "Installed Go_bootstrap for #{ARCH} in #{CREW_PREFIX}/share/go_bootstrap"
  end
end
