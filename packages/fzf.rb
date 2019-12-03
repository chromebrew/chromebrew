require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.19.0'
  source_url 'https://github.com/junegunn/fzf/archive/0.19.0.tar.gz'
  source_sha256 '4d7ee0b621287e64ed450d187e5022d906aa378c5390d8c7c1f843417d2f3422'

  binary_url ({
  })
  binary_sha256 ({
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
