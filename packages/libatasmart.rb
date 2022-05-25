require 'package'

class Libatasmart < Package
  description 'LIBATASMART ATA S.M.A.R.T. Reading and Parsing Library'
  homepage 'http://git.0pointer.net/libatasmart.git/'
  version '0.19'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'http://git.0pointer.net/libatasmart.git'
  git_hashtag "v#{version}"
  git_branch 'master'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libatasmart/0.19_armv7l/libatasmart-0.19-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libatasmart/0.19_armv7l/libatasmart-0.19-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libatasmart/0.19_i686/libatasmart-0.19-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libatasmart/0.19_x86_64/libatasmart-0.19-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fa0524f0bfd1114bfd8f240b1d78c684f4d589c9e574de4ecbea5cc0d6a12970',
     armv7l: 'fa0524f0bfd1114bfd8f240b1d78c684f4d589c9e574de4ecbea5cc0d6a12970',
       i686: '6584e9d789ea8ee639b350ab7d9824dc354abd5b2273ae2b679e1d3f2d652f7e',
     x86_64: 'dd683c2b7d97c91a9f02ffd0bfee195cf5ca0411c17b922498009e35c0203946'
  })

  depends_on 'eudev' => :build

  def self.build
    system './autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
