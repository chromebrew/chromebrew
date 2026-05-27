require 'package'
Package.load_package("#{__dir__}/llvm22_build.rb")

class Llvm22_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm22_build.homepage
  version '22.1.6'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm22_build.version}".orange if version != Llvm22_build.version && !ENV['NESTED_CI']
  license Llvm22_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0fa55943ae34ff5e6971973e031af63597e43b5a82f52d38677be1d8f037d403',
     armv7l: '0fa55943ae34ff5e6971973e031af63597e43b5a82f52d38677be1d8f037d403',
       i686: '6203a0326ae1ad90ed9fe784166aabb863877398c4e7d6fe1683aab7e21b48ce',
     x86_64: '9014947d8a620e25b6675ee3fa8be96246b00783de4199a63d80418f84367e13'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libedit' => :library
  depends_on 'libffi' => :library
  depends_on 'libxml2' => :library
  depends_on 'llvm22_build' => :build
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.preflight
    abort "Update #{CREW_LLVM_VER} first.".lightred if Gem::Version.new(version) < Gem::Version.new(Llvm22_build.version.split('-').first)
  end

  def self.install
    puts 'Installing llvm22_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm22_build.filelist')
    abort 'File list for llvm22_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
