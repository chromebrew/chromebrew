require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '0.9.0'
  compatibility 'all'
  source_url 'https://github.com/cli/cli/archive/v0.9.0.tar.gz'
  source_sha256 '318295e5a662f785662751f1e2cd4b1f613ec3aced1c4e7f1755d27922dbfdbf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/github_cli-0.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/github_cli-0.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/github_cli-0.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/github_cli-0.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e1ac503938d742d34c46ee3c35e0ce1a0f43732c95a20826908633bedc50e625',
     armv7l: 'e1ac503938d742d34c46ee3c35e0ce1a0f43732c95a20826908633bedc50e625',
       i686: '6162d4893573836ace9915244dbf565342dcc41ac6369bc8dfa20f970e1cbc93',
     x86_64: '624f3bf1941d4d1b097c3506af48dbf3fd16d1055057730896a742006e5dc55d',
  })

  depends_on 'go' => :build

  def self.build
    system 'make'
  end

  def self.install
    system "install -Dm755 bin/gh #{CREW_DEST_PREFIX}/bin/gh"
  end

  def self.postinstall
    puts
    puts "Type 'gh' to get started.".lightblue
    puts
  end
end
