require 'package'

class Words < Package
  description 'A dictionary of English words.'
  homepage 'https://en.wikipedia.org/wiki/Words_(Unix)'
  version '1.0.0'
  compatibility 'all'
  source_url 'https://github.com/saltedcoffii/words/releases/download/1.0.0/words-1.0.0.txz'
  source_sha256 '61168093e1ff4f88d838e09e40530cc0c192672ad0dbc01806534e9def296c3b'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_DIR}/usr/local/share"
    FileUtils.cp_r 'dict', "#{CREW_DEST_DIR}/usr/local/share"
    Dir.chdir "#{CREW_DEST_DIR}/usr/local/share/dict" do
      FileUtils.symlink 'american-english', 'words'
    end
  end
end
