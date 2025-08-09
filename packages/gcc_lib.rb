require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Gcc_lib < Package
  description 'GCC shared libs except libgccjit'
  homepage Gcc_build.homepage
  version '15.2.0'
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, libssp, and then binutils in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '849cdc4a2fd962ad775cd2d52fa9fb910b14473ef84bfedc7e4c8bc6a7fde4eb',
     armv7l: '849cdc4a2fd962ad775cd2d52fa9fb910b14473ef84bfedc7e4c8bc6a7fde4eb',
       i686: 'fd88681911f0575574f3d3cc57ea2b034b9f72703b1e2e2e015e518c9c184bd0',
     x86_64: 'dbc8f95410d36f531b4f0caadd1b1bb880ec85e9e19bafe427e641d27b86b17a'
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
