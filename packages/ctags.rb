require 'package'

class Ctags < Package
  description 'Exuberant Ctags is a multilanguage reimplementation of the Unix ctags utility.'
  homepage 'https://sourceforge.net/projects/ctags/'
  version '5.8'
  source_url 'http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz'
  source_sha256 '0e44b45dcabe969e0bbbb11e30c246f81abe5d32012db37395eb57d66e9e99c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ctags-5.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ctags-5.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ctags-5.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ctags-5.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '81a6e5cf24475c276751966ab9ccd884fa7fb339e7c2b6224a928fe9a130bec7',
     armv7l: '81a6e5cf24475c276751966ab9ccd884fa7fb339e7c2b6224a928fe9a130bec7',
       i686: '21fd5f780112b4e7d7df6c5d8cdc5c10e5507b4e597a071b332e9d30efa40ebe',
     x86_64: 'd3003d8b2e138bb774b119d089aa8de6c5d5881dc6229a89149bb974ce8a20a4',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
