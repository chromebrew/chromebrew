require 'package'

class Plowshare < Package
  description 'Command-line tool and engine for managing sharing websites'
  homepage 'https://github.com/mcrapet/plowshare'
  version '2.1.7'
  compatibility 'all'
  source_url 'https://github.com/mcrapet/plowshare/archive/v2.1.7.tar.gz'
  source_sha256 'c17d0cc1b3323f72b2c1a5b183a9fcef04e8bfc53c9679a4e1523642310d22ad'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/plowshare-2.1.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/plowshare-2.1.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/plowshare-2.1.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/plowshare-2.1.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5cd75b7293848e6d5507978fadd107343970f87ca3f41c6ddbbe6a3a3572a845',
     armv7l: '5cd75b7293848e6d5507978fadd107343970f87ca3f41c6ddbbe6a3a3572a845',
       i686: 'ff7f23967d3168ac16c95fe43c6a1312675827b12b2bca26297001354606314f',
     x86_64: '5d416217cb31c3fc9ab7b33cdcd78c5c9c49b7334145b7bbe99465a4b3c7f995',
  })

  depends_on 'recode'

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts "To add command completion for bash, execute the following:".lightblue
    puts "echo '# plowdown completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/bash-completion/completions/plowdown ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/bash-completion/completions/plowdown' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
