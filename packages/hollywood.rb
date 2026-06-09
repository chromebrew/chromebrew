require 'package'

class Hollywood < Package
  description 'Fill your console with Hollywood melodrama technobabble.'
  homepage 'https://a.hollywood.computer/'
  version '1.21'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://httpredir.debian.org/debian/pool/main/h/hollywood/hollywood_#{version}.orig.tar.gz"
  source_sha256 '793ef1f022b376e131c75e05ff1b55a010c0f4193225bb79018855cb9ab89acb'

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
