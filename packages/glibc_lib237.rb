require 'package'
Package.load_package("#{__dir__}/glibc_build237.rb")

class Glibc_lib237 < Package
  description 'glibc libraries'
  homepage Glibc_build237.homepage
  version '2.37-patchelf1' # Do not use @_ver here, it will break the installer.
  license Glibc_build237.license
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc version.split('-').first
  max_glibc version.split('-').first
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7327f9e37705d2b46a2a89300c154e16aa078f93bc3a6ce69932783ce6f56e50',
     armv7l: '7327f9e37705d2b46a2a89300c154e16aa078f93bc3a6ce69932783ce6f56e50',
     x86_64: '37c91128508324b3f865687061e46df5f650cc634489ec9d1a96b88f5917451a'
  })

  depends_on 'glibc_build237' => :build

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
    abort 'File list for Glibc_build237 does not exist! Please run: crew reinstall glibc_build237'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless filename.include?('.so') || filename.include?('bin/')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end

    if ARCH == 'x86_64'
      puts 'Skipping creating symlinks from system Glibc libraries...'.orange
      return
    end

    # Create symlinks to system glibc libraries.
    glibc_libs = %w[libanl.so.1 libc_malloc_debug.so.0 libc.so.6 libdl.so.2 libm.so.6
                    libmvec.so.1 libnss_dns.so.2 libnss_files.so.2 libpthread.so.0
                    libresolv.so.2 librt.so.1 libthread_db.so.1 libutil.so.1]

    glibc_libs.each do |lib|
      # Do not replace libraries that have been patched for our glibc libC.so.6.
      next if Kernel.system("patchelf --print-needed #{File.join(CREW_LIB_PREFIX, lib)} | grep -q libC.so.6")

      puts "Creating symlink of system Glibc's /#{ARCH_LIB}/#{lib} into #{CREW_DEST_LIB_PREFIX}/#{lib}...".orange
      FileUtils.ln_sf "/#{ARCH_LIB}/#{lib}", "#{CREW_DEST_LIB_PREFIX}/#{lib}"
    end
  end

  def self.postinstall
    if (ARCH == 'x86_64') && (LIBC_VERSION.to_f >= 2.35)
      # Overwrite our libc.so.6 with the system glibc libc.so.6, and then use patchelf to link it to ours.
      FileUtils.cp "/#{ARCH_LIB}/libc.so.6", File.join(CREW_LIB_PREFIX, 'libc.so.6.system') and FileUtils.mv File.join(CREW_LIB_PREFIX, 'libc.so.6.system'), File.join(CREW_LIB_PREFIX, 'libc.so.6') unless Kernel.system "patchelf --print-needed #{File.join(CREW_LIB_PREFIX, 'libc.so.6')} | grep -q libC.so.6"
      puts "patchelf is needed. Please run: 'crew install patchelf ; crew postinstall #{name}'".lightred unless File.file?(File.join(CREW_PREFIX, 'bin/patchelf'))
      # Link the system libc.so.6 to also require our renamed libC.so.6
      # which provides the float128 functions strtof128, strfromf128,
      # and __strtof128_nan.
      libc_patch_libraries = %w[libc.so.6 libm.so.6 libstdc++.so.6]
      libc_patch_libraries.keep_if { |lib| File.file?(File.join(CREW_LIB_PREFIX, lib)) }
      libc_patch_libraries.delete_if { |lib| Kernel.system "patchelf --print-needed #{File.join(CREW_LIB_PREFIX, lib)} | grep -q libC.so.6" }

      return if libc_patch_libraries.empty?

      if File.file?(File.join(CREW_LIB_PREFIX, 'libC.so.6'))
        Dir.chdir(CREW_LIB_PREFIX) do
          libc_patch_libraries.each do |lib|
            FileUtils.cp lib, "#{lib}.tmp"
            Kernel.system "patchelf --add-needed libC.so.6 #{lib}.tmp" and Kernel.system "patchelf --remove-needed libc.so.6 #{lib}.tmp"
            FileUtils.mv "#{lib}.tmp", lib
            puts "#{lib} patched for use with Chromebrew's glibc.".lightgreen
          end
        end
      end
    end
  end
end
