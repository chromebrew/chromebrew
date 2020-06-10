require 'package'

class Gnome_doc_utils < Package
  description 'Gnome Documentation Utilities'
  homepage 'https://github.com/GNOME/gnome-doc-utils'
  version '0.20.10'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gnome-doc-utils/0.20/gnome-doc-utils-0.20.10.tar.xz'
  source_sha256 'cb0639ffa9550b6ddf3b62f3b1add92fb92ab4690d351f2353cffe668be8c4a6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_doc_utils-0.20.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_doc_utils-0.20.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_doc_utils-0.20.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_doc_utils-0.20.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'be5d308c26af775dcebf0fe9a3e17905d31fa983b4d6c1c590ceba5a50b89504',
     armv7l: 'be5d308c26af775dcebf0fe9a3e17905d31fa983b4d6c1c590ceba5a50b89504',
       i686: '51793e4e7769e1a0abc40351893c8aa5bd75f63f8202cf59b8002c48b0fe3be1',
     x86_64: '7d42545db45cd71173b27f329526932d1fc24e00494dfd704f51f11804676986',
  })

  depends_on 'rarian'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
