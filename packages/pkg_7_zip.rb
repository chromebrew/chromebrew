require 'package'

class Pkg_7_zip < Package
  description 'Official implantation of 7za.exe in Linux. File archiver with a high compression ratio.'
  homepage 'https://www.7-zip.org'
  license 'LGPL-2.1+'
  version '25.01'
  compatibility 'all'
  source_url "https://www.7-zip.org/a/7z#{version.delete('.')}-src.tar.xz"
  source_sha256 'ed087f83ee789c1ea5f39c464c55a5c9d4008deb0efe900814f2df262b82c36e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '265a5acf546bddd5562539d675bddcfddb224d268371fde4d55a012ea2ac8862',
     armv7l: '265a5acf546bddd5562539d675bddcfddb224d268371fde4d55a012ea2ac8862',
       i686: '84b54312cf973281258d1ba41c31d5aae6387feae429277d77b335f9e37d8575',
     x86_64: '68e0f4702cffd908bf24dcd84036e7093a2c0e882256f17992785f50178fa0cc'
  })

  depends_on 'asmc' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  no_env_options

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
