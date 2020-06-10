require 'package'

class Aspell_en < Package
  description 'English Aspell Dictionary'
  homepage 'https://ftpmirror.gnu.org/aspell/dict/0index.html'
  version '2019.10.06-0'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/aspell/dict/en/aspell6-en-2019.10.06-0.tar.bz2'
  source_sha256 '24334b4daac6890a679084f4089e1ce7edbe33c442ace776fa693d8e334f51fd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2019.10.06-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2019.10.06-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2019.10.06-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2019.10.06-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a738f11f46ba13405bd69ed228494415df6dd43c82639df3dee97a923bf6f43a',
     armv7l: 'a738f11f46ba13405bd69ed228494415df6dd43c82639df3dee97a923bf6f43a',
       i686: 'f0d6533f73c87c5a6dc8cd0c5e2db3cee262f208c10ec4aa7bb9af1f7b78a2ad',
     x86_64: 'd346224eada4650b7bacc1146e3664800f2728287e184b16a6c95f46ba2cf805',
  })

  depends_on 'aspell'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
