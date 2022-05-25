require 'package'

class Pkg_7_zip < Package
  description 'Official implantation of 7za.exe in Linux. File archiver with a high compression ratio.'
  homepage 'https://www.7-zip.org'
  license 'LGPL-2.1+'
  version '21.07'
  compatibility 'all'
  source_url 'https://www.7-zip.org/a/7z2107-src.tar.xz'
  source_sha256 '213d594407cb8efcba36610b152ca4921eda14163310b43903d13e68313e1e39'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pkg_7_zip/21.07_armv7l/pkg_7_zip-21.07-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pkg_7_zip/21.07_armv7l/pkg_7_zip-21.07-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pkg_7_zip/21.07_i686/pkg_7_zip-21.07-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pkg_7_zip/21.07_x86_64/pkg_7_zip-21.07-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '83e2070e6eefb32e53260f7d029d3ad7d72fb1c6c64890cd24d0574ffc5e33e1',
     armv7l: '83e2070e6eefb32e53260f7d029d3ad7d72fb1c6c64890cd24d0574ffc5e33e1',
       i686: '3b7bb7e973d6c8ffa4a95e4f763050f04bd20f098976a1fc098d43386e794cea',
     x86_64: 'c3679390e45a5f1cc8cb45f2bab8c7412685505ddf1cbae693233dd1f39d6734'
  })

  no_env_options

  # needed for compiling the faster asm binary in x86/x64
  depends_on 'asmc' => :build if %w[i686 x86_64].include?(ARCH)

  @_makefile = case ARCH
               when 'x86_64'
                 'cmpl_gcc_x64.mak'
               when 'i686'
                 'cmpl_gcc_x86.mak'
               else
                 'cmpl_gcc.mak'
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
