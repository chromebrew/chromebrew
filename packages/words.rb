require 'package'

class Words < Package
  description 'A dictionary of English words.'
  homepage 'https://en.wikipedia.org/wiki/Words_(Unix)'
  version '1.0.0'
  compatibility 'all'
  source_url 'https://github.com/saltedcoffii/words/releases/download/1.0.0/words-1.0.0.txz'
  source_sha256 '61168093e1ff4f88d838e09e40530cc0c192672ad0dbc01806534e9def296c3b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/words-1.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/words-1.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/words-1.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/words-1.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '42309c5ae83987a15d29c6458db87eaa4402c068dedb8f01258cec29c4672eeb',
     armv7l: '42309c5ae83987a15d29c6458db87eaa4402c068dedb8f01258cec29c4672eeb',
       i686: '3b31ade23762c2e604890643ba5d7d3b579af215a7ec6049cb2b21c4e269990a',
     x86_64: '7f05c55148da13219f63f09588465197f9417c6a950464ffec42eea6626ef2b2',
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.cp_r 'dict', "#{CREW_DEST_PREFIX}/share"
    Dir.chdir "#{CREW_DEST_PREFIX}/share/dict" do
      FileUtils.symlink 'american-english', 'words'
    end
  end
end
