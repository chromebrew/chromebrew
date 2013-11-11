require 'package'

class Zsh < Package
  version '5.0.2'
  source_url 'http://downloads.sourceforge.net/project/zsh/zsh/5.0.2/zsh-5.0.2.tar.bz2?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fzsh%2Ffiles%2F&ts=1384135329&use_mirror=heanet'
  source_sha1 '9f55ecaaae7cdc1495f91237ba2ec087777a4ad9'
  binary_url ({
    x86_64: 'https://dl.dropboxusercontent.com/s/0m8ms5b97t0r0s8/zsh-5.0.2-chromeos-x86_64.tar.gz?dl=1&token_hash=AAHiOSakPQiU2zhohXT1dVZyl6zphvESvADcrhyMomniAA'
  })
  binary_sha1 ({
    x86_64: 'b9f87032e60cd04ce7e709a94f1cf5a8a71d0090'
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
