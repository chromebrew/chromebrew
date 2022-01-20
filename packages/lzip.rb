require 'package'

class Lzip < Package
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.22-3'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzip-1.22.tar.gz'
  source_sha256 'c3342d42e67139c165b8b128d033b5c96893a13ac5f25933190315214e87a948'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-3_armv7l/lzip-1.22-3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-3_armv7l/lzip-1.22-3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-3_i686/lzip-1.22-3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-3_x86_64/lzip-1.22-3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd9f7c85e23c7b2325ceb7d9b1de5f0ed978418214c49b6a2ac022fba638a16b5',
     armv7l: 'd9f7c85e23c7b2325ceb7d9b1de5f0ed978418214c49b6a2ac022fba638a16b5',
       i686: '4765d6b4470651f3d51a6200c83be04cf5d66918513d066a4de49e68b6b5814a',
     x86_64: '0ae3146a01f2412c726f20a48c6eee208b4008bc5b122760d6b8eaf4d888a8be'
  })

  depends_on 'musl_native_toolchain' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
    system "./configure --prefix=#{CREW_MUSL_PREFIX} \
      --datarootdir=#{CREW_PREFIX}/share \
      #{MUSL_ENV_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_s '../share/musl/bin/lzip', 'lzip'
    end
  end

  def self.check
    system 'make', 'check'
  end
end
