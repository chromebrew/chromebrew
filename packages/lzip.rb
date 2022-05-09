require 'package'

class Lzip < Package
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.23'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzip-1.23.tar.gz'
  source_sha256 'c3342d42e67139c165b8b128d033b5c96893a13ac5f25933190315214e87a948'

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
