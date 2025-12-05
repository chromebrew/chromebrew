require 'package'

class B2 < Package
  description 'B2 makes it easy to build C++ projects, everywhere.'
  homepage 'https://www.bfgroup.xyz/b2/'
  version '5.3.3'
  license 'BSL 1.0'
  compatibility 'all'
  source_url 'https://github.com/bfgroup/b2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b943e619859f8b7208f62237f540fd722198c538241e7e515333f5149ad0316d',
     armv7l: 'b943e619859f8b7208f62237f540fd722198c538241e7e515333f5149ad0316d',
       i686: '9c2cfa45722d75f4b1d35a0e7899ae9ffe845a33a706a0d891a6bd2d6b810edc',
     x86_64: '0a51077f71a657c5cd9d4aa950acc26e622eec16d2fddeb98ee4a26d56ac1edf'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 install --prefix=#{CREW_DEST_PREFIX}"
  end
end
