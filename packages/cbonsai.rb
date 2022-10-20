require 'package'

class Cbonsai < Package
  description 'A CLI bonsai tree generator, grow bonsai trees in our terminal'
  homepage 'https://gitlab.com/jallbrit/cbonsai'
  @_ver = '1.3.1'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://gitlab.com/jallbrit/cbonsai.git'
  git_hashtag "v#{@_ver}"

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'scdoc' => :build

  def self.patch
    # Use correct gcc compiler
    system "sed -i 's:= cc:= #{CREW_TGT}-gcc:' Makefile"

    # Move the manpage from section 1 to section 6
    # (See https://gitlab.com/jallbrit/cbonsai/-/merge_requests/21 for reasoning)
    downloader 'https://gitlab.com/jallbrit/cbonsai/-/merge_requests/21.patch', 'd56f84041e7db05437812d3cfee51766210247ccbcbb0dface72b0a0f5407599'
    system 'patch -Np1 21.patch'
  end

  def self.build
    system 'make'
  end

  def self.check
    # At the time of writing (20 Oct 2022), cbonsai has no checks
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
