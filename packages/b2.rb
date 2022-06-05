require 'package'

class B2 < Package
  description 'B2 makes it easy to build C++ projects, everywhere.'
  homepage 'https://www.bfgroup.xyz/b2/'
  @_ver = '4.9.1'
  version @_ver
  license 'BSL 1.0'
  compatibility 'all'
  source_url 'https://github.com/bfgroup/b2.git'
  git_hashtag @_ver

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 install --prefix=#{CREW_DEST_PREFIX}"
  end
end
