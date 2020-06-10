require 'package'

class Thefuck < Package
  description 'Magnificent app which corrects your previous console command.'
  homepage 'https://github.com/nvbn/thefuck'
  version '3.26'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/nvbn/thefuck/3.26/README.md'
  source_sha256 '105e10e37c4c1430fe6bc3a48c9508254048721825ae14856d713de61c95bc66'

  def self.install
    system "pip3 install thefuck --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end

  def self.postinstall
    system 'fuck && fuck'
  end
end
