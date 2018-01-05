require 'package'

class Scron < Package
  description 'Simple cron daemon.'
  homepage 'https://git.2f30.org/scron/'
  version '0.4'
  source_url 'https://git.2f30.org/scron/log.html'
  source_sha256 'e37c93d910cc5e0793a6d354d5a3de6f1e963656e7546abb7bca5410c90792df'

  binary_url ({
  })
  binary_sha256 ({
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
