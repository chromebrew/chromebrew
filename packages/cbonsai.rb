require 'package'

class Cbonsai < Package
  description 'A CLI bonsai tree generator, grow bonsai trees in our terminal'
  homepage 'https://gitlab.com/jallbrit/cbonsai'
  version '1.3.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://gitlab.com/jallbrit/cbonsai.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cbonsai/1.3.1_armv7l/cbonsai-1.3.1-chromeos-armv7l.tar.zst',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cbonsai/1.3.1_armv7l/cbonsai-1.3.1-chromeos-armv7l.tar.zst',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cbonsai/1.3.1_i686/cbonsai-1.3.1-chromeos-i686.tar.zst',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cbonsai/1.3.1_x86_64/cbonsai-1.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
     aarch64: '3cbeff88cd8a5bb190e5da9dd77f7007ed26ff022e52eacfb80e9c3e0cd79d74',
      armv7l: '3cbeff88cd8a5bb190e5da9dd77f7007ed26ff022e52eacfb80e9c3e0cd79d74',
        i686: '5ae0df0e6bac0b3946ae2f9d023c94cd153566880c2ad5e333bb0a2e2ee80ee0',
      x86_64: '0783ebe521e25be4c7c251582bf1d3be3c74a319b4e8ea4c673dcea7173c2377'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'scdoc' => :build

  def self.patch
    # Use correct gcc compiler
    system "sed -i 's:= cc:= #{CREW_TGT}-gcc:' Makefile"

    # Move the manpage from section 1 to section 6
    # (See https://gitlab.com/jallbrit/cbonsai/-/merge_requests/21 for reasoning)
    system "sed -i 's:man1:man6:g' Makefile"
    system "sed -i 's:cbonsai.1:cbonsai.6:g' Makefile"
    system "sed -i 's:cbonsai(1):cbonsai(6):' cbonsai.scd"
  end

  def self.build
    system 'make'
  end

  def self.check
    # At the time of writing (20 Oct 2022), cbonsai has no checks
    # system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
