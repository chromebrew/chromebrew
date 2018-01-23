require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.17.3'
  source_url 'https://github.com/junegunn/fzf/archive/0.17.3.tar.gz'
  source_sha256 'e843904417adf926613431e4403fded24fade56269446e92aac6ff1db86af81e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fzf-0.17.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fzf-0.17.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fzf-0.17.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fzf-0.17.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3a22a06766e073474519a14d80cab175213006b12e328bf3c7d8c1b5f7d1bc72',
     armv7l: '3a22a06766e073474519a14d80cab175213006b12e328bf3c7d8c1b5f7d1bc72',
       i686: '6c93126d4fc99d6f3203ae4ec1c322116db699c1416159087b7386741285cc53',
     x86_64: 'eed9f071b8f6fb2d551bc1730f2309f57ef2e54bb6585438cfd339f93ec3bb35',
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
