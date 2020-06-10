require 'package'

class Dehtml < Package
  description 'Dehtml removes HTML constructs from documents for indexing, spell checking and so on.'
  homepage 'http://www.moria.de/~michael/dehtml/'
  version '1.8'
  compatibility 'all'
  source_url 'http://www.moria.de/~michael/dehtml/dehtml-1.8.tar.gz'
  source_sha256 'a00e86643b0aa73861e9d8d619a80370f0f99519d34ce12459fab77f5f6b5bde'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dehtml-1.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dehtml-1.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dehtml-1.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dehtml-1.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '01a111714310dcf69cbdc0cc132ce03151742939708911dabe9b6af5ec9c5c5b',
     armv7l: '01a111714310dcf69cbdc0cc132ce03151742939708911dabe9b6af5ec9c5c5b',
       i686: '1f0c1048aeb7170a1d21e57d89c573b3a871b98026ef1885eb92fbcccbbf68b6',
     x86_64: '76346ded317eea0d12ac0d02dbf8947f4b3251333dcdfb1af5fbab03eb334e66',
  })

  depends_on 'icu4c'

  def self.build
    system "./configure --prefix=#{CREW_DEST_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make install'
  end
end
