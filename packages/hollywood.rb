require 'package'

class Hollywood < Package
  description 'Fill your console with Hollywood melodrama technobabble.'
  homepage 'https://a.hollywood.computer/'
  version '1.25'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/hollywood.git'
  git_hashtag version

  depends_on 'byobu'
  depends_on 'apg'
  depends_on 'bmon'
  depends_on 'cmatrix'
  depends_on 'htop'
  depends_on 'jp2a'
  depends_on 'mlocate'
  depends_on 'moreutils'
  depends_on 'speedometer'
  depends_on 'tree'
  depends_on 'util_linux'

  # Hollywood doesn't need binaries
  no_compile_needed

  def self.patch
    # Fix ls: cannot access '/usr/local/bin/../lib/hollywood': No such file or directory
    system "sed -i 's,lib/,lib#{CREW_LIB_SUFFIX}/,g' ./bin/hollywood"
    # Fix ls: cannot access '/usr/local/bin/../lib/wallstreet/': No such file or directory
    system "sed -i 's,lib/,lib#{CREW_LIB_SUFFIX}/,g' ./bin/wallstreet"
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.cp_r './share/', CREW_DEST_PREFIX
    FileUtils.cp_r './lib/hollywood/', CREW_DEST_LIB_PREFIX
    FileUtils.cp_r './lib/wallstreet/', CREW_DEST_LIB_PREFIX
    FileUtils.install './bin/hollywood', "#{CREW_DEST_PREFIX}/bin/hollywood", mode: 0o755
    FileUtils.install './bin/wallstreet', "#{CREW_DEST_PREFIX}/bin/wallstreet", mode: 0o755
  end
end
