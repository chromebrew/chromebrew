require 'package'

class B2 < Package
  description 'B2 makes it easy to build C++ projects, everywhere.'
  homepage 'https://www.bfgroup.xyz/b2/'
  version '5.5.3'
  license 'BSL 1.0'
  compatibility 'all'
  source_url 'https://github.com/bfgroup/b2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd92c84148de029bf83e320ae773ab1dd121edcbaeb5f220792152ecfb72993bd',
     armv7l: 'd92c84148de029bf83e320ae773ab1dd121edcbaeb5f220792152ecfb72993bd',
       i686: 'e7f8f7de32471df9d7e8324f9791b3b118d0a51310d117fa9bd1373ec62ddaad',
     x86_64: '96275f5679ca147c8f268a987928919c7c0fb1ba04a9949cc98f0260bdd1f138'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 install --prefix=#{CREW_DEST_PREFIX}"
  end
end
