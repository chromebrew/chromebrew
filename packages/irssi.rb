require 'package'

class Irssi < Package
  description 'Modular text mode IRC client with Perl scripting'
  homepage 'https://irssi.org/'
  version '1.0.5-1'
  source_url 'https://github.com/irssi/irssi/releases/download/1.0.5/irssi-1.0.5.tar.xz'
  source_sha256 'c2556427e12eb06cabfed40839ac6f57eb8b1aa6365fab6dfcd331b7a04bb914'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/irssi-1.0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/irssi-1.0.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/irssi-1.0.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/irssi-1.0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7c55448ba8a2ee0f520d1e26354995ae70703493fe9587879cc6ae1a9a4d2007',
     armv7l: '7c55448ba8a2ee0f520d1e26354995ae70703493fe9587879cc6ae1a9a4d2007',
       i686: '1d9e450d6a094abd33cdfe4785577a6473f5fa1dcee22036abaca66e9a01b3ba',
     x86_64: '52182ab6c6618589a8a792cc3d4b98503a3eee71dc04974e3590ce55cc80d3e9',
  })

  depends_on 'glib' => :build
  depends_on 'ncurses'
  depends_on 'openssl'
  depends_on 'perl'

  def self.build
    system './configure',
	     "--prefix=#{CREW_PREFIX}",
	     "--libdir=#{CREW_LIB_PREFIX}",
	     "--sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
