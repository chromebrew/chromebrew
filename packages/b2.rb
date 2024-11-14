require 'package'

class B2 < Package
  description 'B2 makes it easy to build C++ projects, everywhere.'
  homepage 'https://www.bfgroup.xyz/b2/'
  version '5.2.1'
  license 'BSL 1.0'
  compatibility 'all'
  source_url 'https://github.com/bfgroup/b2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc6346c901e7433af6a5faf05b7b7d968af58764267858473409eeed1f5dad5e',
     armv7l: 'fc6346c901e7433af6a5faf05b7b7d968af58764267858473409eeed1f5dad5e',
       i686: '85a397c2afe175bd53dd4bf5e388935854f24cc6b27edbd42ff343df6dc23c8c',
     x86_64: 'ade42866d817c30e5d19e55ede2e9186d145b0e5735f5c8e097031b6811acfbb'
  })

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 install --prefix=#{CREW_DEST_PREFIX}"
  end
end
