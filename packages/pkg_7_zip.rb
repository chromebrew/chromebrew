require 'package'

class Pkg_7_zip < Package
  description 'Official implantation of 7za.exe in Linux. File archiver with a high compression ratio.'
  homepage 'https://www.7-zip.org'
  license 'LGPL-2.1+'
  version '26.01'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.7-zip.org/a/7z#{version.delete('.')}-src.tar.xz"
  source_sha256 'b2389e0e930b2f9a348cf0fe7d9870a46482a8ec044ee0bdf42e2136db31c3d6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '146ba0924cccdbc1802b79f58328856a33ecea724ebca0effe63a68497dc1c21',
     armv7l: '146ba0924cccdbc1802b79f58328856a33ecea724ebca0effe63a68497dc1c21',
     x86_64: 'e5296c9c59d9b6570160c4f0c62678b87c2c63c44d7c00fa4ac5150a5ed805dc'
  })

  depends_on 'asmc' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'uasm' => :build

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
