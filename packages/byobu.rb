require 'buildsystems/autotools'

class Byobu < Autotools
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'https://www.byobu.org'
  version '7.7'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/byobu.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ec6453cf9b59735d13e477e1402974d6578c62c02458820c415c29d4b444ae5',
     armv7l: '1ec6453cf9b59735d13e477e1402974d6578c62c02458820c415c29d4b444ae5',
       i686: '7f66ea32ae6ae64d51a836fc1ba4a4506ed5079bddfbaf857fe817059a739a0b',
     x86_64: '40f0c09549dacfc08b48aed0d755bd5fb56957035c9963ecdc33897927fee527'
  })

  depends_on 'tmux' unless File.exist? "#{CREW_PREFIX}/bin/screen"

  def self.patch
    system "sed -i '318,328d' ./usr/lib/byobu/include/shutil"
    system "sed -i '34,36d' ./usr/lib/byobu/release"
  end
end
