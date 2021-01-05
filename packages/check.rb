require 'package'

class Check < Package
  description 'A unit testing framework for C'
  homepage 'https://libcheck.github.io/check/'
  version '0.15.2'
  source_url 'https://github.com/libcheck/check/releases/download/0.15.2/check-0.15.2.tar.gz'
  source_sha256 'a8de4e0bacfb4d76dd1c618ded263523b53b85d92a146d8835eb1a52932fa20a'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/check-0.15.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/check-0.15.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/check-0.15.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/check-0.15.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '935119bc79d705b92a3a67d422b86aa466284bc907026635c06b1767ca1bf346',
      armv7l: '935119bc79d705b92a3a67d422b86aa466284bc907026635c06b1767ca1bf346',
        i686: 'f248bc49996c8a5778574cb899647f493b5411c2ce829f96b899c9233de91927',
      x86_64: '7dc419c3be381ccf3575554bbd8e9d4ddd6cc38ede64c29d9b0922ab86d4624a',
  })


  def self.build
    system "autoreconf -fvi"
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "env CC=gcc LD=ld \
      cmake -G Ninja \
      -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCHECK_ENABLE_TIMEOUT_TESTS=OFF \
      -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX} \
      .."
      system "ninja"
    end
  end
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
