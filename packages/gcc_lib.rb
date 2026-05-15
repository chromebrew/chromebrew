require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Gcc_lib < Package
  description 'GCC shared libs except libgccjit'
  homepage Gcc_build.homepage
  version '16.1.0'
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, libssp, and then binutils in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef980532a7dcb86e3be5a4fdc6dd4bd30d117ad1c2a6fe041083b6a818741d5c',
     armv7l: 'ef980532a7dcb86e3be5a4fdc6dd4bd30d117ad1c2a6fe041083b6a818741d5c',
       i686: '25e4df9874a87308111eebb2e046ae9e89eb499744f92f8193215f2e2ec0a6eb',
     x86_64: 'acbf9ed19bced6c39d71d22fc83479a33e7f7a52cc2b2f73af70eeb569a03cb6'
  })

  depends_on 'gcc_build' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing Gcc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'gcc_build.filelist')
    abort 'File list for Gcc_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next unless filename.include?('.so') && !filename.include?('libgccjit')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
