require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Gcc_lib < Package
  description 'GCC shared libs except libgccjit'
  homepage Gcc_build.homepage
  version '15.1.0' # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4be06dfe638ac3ffa3312c7cd08ff564947f5f07ec67db657c65597237e692c9',
     armv7l: '4be06dfe638ac3ffa3312c7cd08ff564947f5f07ec67db657c65597237e692c9',
       i686: '90f15d9ddcfc44ba287e799acc7ba9ca5e9d877e75573063d1d18a8cdc738c79',
     x86_64: '0550e69986bc8700ec65dd9634a4edfae5d7135ed93a15b14b25000f4a623e53'
  })

  depends_on 'gcc_build' => :build
  depends_on 'glibc' # R

  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing Gcc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'gcc_build.filelist')
    abort 'File list for Gcc_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless filename.include?('.so') && !filename.include?('libgccjit')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
