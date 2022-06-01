require 'package'

class Lzip < Package
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.23'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzip-1.23.tar.gz'
  source_sha256 '4792c047ddf15ef29d55ba8e68a1a21e0cb7692d87ecdf7204419864582f280d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.23_armv7l/lzip-1.23-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.23_armv7l/lzip-1.23-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.23_i686/lzip-1.23-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.23_x86_64/lzip-1.23-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '97ce9598576c9d2dcdaa7c83561b11aa9d8cbff33506e066dd8b22b453eae382',
     armv7l: '97ce9598576c9d2dcdaa7c83561b11aa9d8cbff33506e066dd8b22b453eae382',
       i686: '7e4722a56e697db590ccf6cf403f06de9a5b2985c32e73539d10f977dff8eb85',
     x86_64: '4c9019eab5a02dbaa1b68c6c0cb0f36d34ae9b7a4f9fac145fc61ea90d7eac4a'
  })

  depends_on 'musl_native_toolchain' => :build

  is_static
  is_musl

  def self.build
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
