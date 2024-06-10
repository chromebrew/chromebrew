require 'package'
require_relative 'glibc_build237'

class Glibc_lib237 < Package
  description 'glibc libraries'
  homepage Glibc_build237.homepage
  version '2.37-1' # Do not use @_ver here, it will break the installer.
  license Glibc_build237.license
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'efb6e1f5593f97b6fe8232e7e265911bba0f632e178f86c3f0412c1265cf2962',
     armv7l: 'efb6e1f5593f97b6fe8232e7e265911bba0f632e178f86c3f0412c1265cf2962',
     x86_64: '2645a7f26f0d0f007c57f296ef18c853253b98da4756f7ada840a40147c8c8ed'
  })

  depends_on 'glibc_build237' => :build
  depends_on 'glibc' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_upstream_update

  def self.preflight
    abort 'Glibc_lib requires glibc = 2.37.' unless Gem::Version.new(LIBC_VERSION.to_s) == Gem::Version.new('2.37')
  end

  def self.install
    puts 'Installing Glibc_build237 to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'glibc_build237.filelist')
    abort 'File list for Glibc_build237 does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless filename.include?('.so') || filename.include?('bin/')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
    # Symlinks to system libraries.
    %w[libanl.so.1 libc_malloc_debug.so.0 libc.so.6 libdl.so.2 libm.so.6
       libmvec.so.1 libnss_dns.so.2 libnss_files.so.2 libpthread.so.0
       libresolv.so.2 librt.so.1 libthread_db.so.1 libutil.so.1].each do |lib|
      FileUtils.ln_sf "/#{ARCH_LIB}/#{lib}", "#{CREW_DEST_LIB_PREFIX}/#{lib}"
    end
  end
end
