require 'package'

class Scron < Package
  description 'Simple cron daemon.'
  homepage 'https://git.2f30.org/scron/'
  version '0.4'
  compatibility 'all'
  source_url 'https://git.2f30.org/scron/log.html'
  source_sha256 'e37c93d910cc5e0793a6d354d5a3de6f1e963656e7546abb7bca5410c90792df'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/scron-0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/scron-0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/scron-0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/scron-0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e8029fb37ee2b5c2a4e00833ef9737177f2d40108802b49a5055892e6edb9b39',
     armv7l: 'e8029fb37ee2b5c2a4e00833ef9737177f2d40108802b49a5055892e6edb9b39',
       i686: '092d0273719a9e4bf43847b9001ce01fb2cd71f5a026046db730ad9ddfe306d8',
     x86_64: '7b4e12d01286d0a2b55c04b320b909662a9caa4e6b569dc0d2d9a05fe1d3c8fa',
  })

  def self.build
    system 'git clone git://git.2f30.org/scron.git'
    Dir.chdir 'scron' do
      system 'git checkout 0.4'
      system "sed -i 's,PREFIX = /usr/local,PREFIX = #{CREW_DEST_PREFIX},' Makefile"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'scron' do
      system 'make install'
    end
  end
end
