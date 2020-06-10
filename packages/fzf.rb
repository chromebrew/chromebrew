require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.19.0'
  compatibility 'all'
  source_url 'https://github.com/junegunn/fzf/archive/0.19.0.tar.gz'
  source_sha256 '4d7ee0b621287e64ed450d187e5022d906aa378c5390d8c7c1f843417d2f3422'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fzf-0.19.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fzf-0.19.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fzf-0.19.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fzf-0.19.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9d2a4e6bd684d8d22efb0201fd3e1cff3351047093c2aa5eefc6e274c0923109',
     armv7l: '9d2a4e6bd684d8d22efb0201fd3e1cff3351047093c2aa5eefc6e274c0923109',
       i686: 'e4654de855507441b1c236689009156633255a666e06f4dae5892cf27d3200e8',
     x86_64: 'f4d22ecf84cf14f146346f667589e53df76f70e29433aac97ac469df0bf0f651',
  })

  depends_on 'go' => :build

  def self.build
    system "make"
    system "sed -i 's,bin/fzf,#{CREW_DEST_PREFIX}/bin/fzf,' Makefile"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "make install"
  end
end
