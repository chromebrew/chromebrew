require 'package'

class Libexecinfo < Package
  description 'BSD licensed clone of backtrace facility'
  homepage 'https://github.com/mikroskeem/libexecinfo'
  version '1.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/mikroskeem/libexecinfo.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad8d41fce7e4648f8ff267f65e765538879a4c66e4f4a894f872021ae6989c40',
     armv7l: 'ad8d41fce7e4648f8ff267f65e765538879a4c66e4f4a894f872021ae6989c40',
       i686: 'fc8e0b4c6c5134e8539c2ba82cf7ddf63f20edcb06526ba3c06d2336a042f7e1',
     x86_64: 'f3e47a86b511d495023f523e165717f0902371b139f8a13ee270c0fe5785db97'
  })

  depends_on 'glibc' # R

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
