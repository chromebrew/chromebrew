require 'package'

class B2 < Package
  description 'B2 makes it easy to build C++ projects, everywhere.'
  homepage 'https://www.bfgroup.xyz/b2/'
  version '5.6.2'
  license 'BSL 1.0'
  compatibility 'all'
  source_url 'https://github.com/bfgroup/b2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'deab2cd24cc4998d639f160e88cba47d36d1d612953c93ac2216d0d5d767220d',
     armv7l: 'deab2cd24cc4998d639f160e88cba47d36d1d612953c93ac2216d0d5d767220d',
       i686: '68d4547701a3ba5c1cac3a1b16367e9b6cf4f677c8ec158775d9b46024cff1ae',
     x86_64: '95824efd5b233037d97adf576f54ef3add073c1fc876b359a57e0c39dd5b2ef0'
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
