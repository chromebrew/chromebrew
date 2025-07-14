require 'package'

class Pkg_7_zip < Package
  description 'Official implantation of 7za.exe in Linux. File archiver with a high compression ratio.'
  homepage 'https://www.7-zip.org'
  license 'LGPL-2.1+'
  version '25.00'
  compatibility 'all'
  source_url "https://www.7-zip.org/a/7z#{version.delete('.')}-src.tar.xz"
  source_sha256 'bff9e69b6ca73a5b8715d7623870a39dc90ad6ce1f4d1070685843987af1af9b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f18aa14a9604cf54c390ccf58135469f543a8a1a4bdef667525da18f58fcd9d',
     armv7l: '7f18aa14a9604cf54c390ccf58135469f543a8a1a4bdef667525da18f58fcd9d',
       i686: 'eff5cd8e4efa6d65741d0b5d6ff08919518c043e5a27529e3c923360ea3f04aa',
     x86_64: 'a80ffe51d0fa5d7526965fbce635efc67b193a0476cc45c82020369252a71369'
  })

  no_env_options

  depends_on 'asmc' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  @_makefile = case ARCH
               when 'x86_64'
                 'cmpl_gcc_x64.mak'
               when 'i686'
                 'cmpl_gcc_x86.mak'
               else
                 'cmpl_gcc_arm.mak'
               end

  @_bundles = {
    'Alone2' => "#{CREW_DEST_PREFIX}/bin/7zz",
 'Format7zF' => "#{CREW_DEST_LIB_PREFIX}/7z.so"
  }

  @_bundle_dir = 'CPP/7zip/Bundles'

  def self.patch
    system "sed -i 's#b/g_$(PLATFORM)#builddir#g' CPP/7zip/var_gcc*.mak"
  end

  def self.build
    @_bundles.each_pair do |bundle, _bin_dest|
      system 'make', '-f', "../../#{@_makefile}", chdir: "#{@_bundle_dir}/#{bundle}"
    end
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_PREFIX}/bin", CREW_DEST_LIB_PREFIX]

    @_bundles.each_pair do |bundle, bin_dest|
      bin = File.basename(bin_dest)
      FileUtils.install "#{@_bundle_dir}/#{bundle}/builddir/#{bin}", bin_dest
    end

    FileUtils.ln_s '7zz', "#{CREW_DEST_PREFIX}/bin/7z"
    FileUtils.ln_s '7zz', "#{CREW_DEST_PREFIX}/bin/7za"
    FileUtils.ln_s '7zz', "#{CREW_DEST_PREFIX}/bin/7zr"
  end
end
