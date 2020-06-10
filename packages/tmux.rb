require 'package'

class Tmux < Package
  description 'tmux is a terminal multiplexer'
  homepage 'https://tmux.github.io/'
  version '2.9'
  compatibility 'all'
  source_url 'https://github.com/tmux/tmux/releases/download/2.9/tmux-2.9.tar.gz'
  source_sha256 '34901232f486fd99f3a39e864575e658b5d49f43289ccc6ee57c365f2e2c2980'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '99938a59550bdbc0354332c6960a8648fc5096d611ae0b595c1b806d6fbe9064',
     armv7l: '99938a59550bdbc0354332c6960a8648fc5096d611ae0b595c1b806d6fbe9064',
       i686: 'b8266f980bb84415518a129aa816486e76a518fe52766fbb683d2c3144ef106b',
     x86_64: 'd16ffdb0c0cc7378587e43a06823404061e7db65a4fcbcaf7f59548c3eb3646f',
  })

  depends_on 'libevent'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses ./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
