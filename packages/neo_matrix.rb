require 'package'

class Neo_matrix < Package
  description 'Simulates the digital rain from "The Matrix" (A CMatrix clone with 32-bit color and Unicode support)'
  homepage 'https://github.com/st3w/neo'
  version '0.6.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/st3w/neo.git'
  git_hashtag "v#{version}"

  depends_on 'ttf_hanazono' # L
  depends_on 'glibc' # R
  depends_on 'ncurses' # R

  def self.patch
    # We like having a verbose autoreconf
    system "sed -i 's:^autoreconf:autoreconf --verbose:' autogen.sh"
  end

  def self.build
    system './autogen.sh'
    # The program name is neo-matrix for us
    # "neo" refers to different software that existed before this neo
    system "./configure #{CREW_OPTIONS.sub '--program-suffix=\'\'', ''} \
      --program-suffix='-matrix'"
    system 'make'
  end

  def self.check
    # At the time of writing (20 Oct 2022), neo has no checks
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
