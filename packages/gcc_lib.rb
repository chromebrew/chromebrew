require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Gcc_lib < Package
  description 'GCC shared libs except libgccjit'
  homepage Gcc_build.homepage
  version '16.2.0'
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, libssp, and then binutils in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc8b6a89a22f628c041aaf09f751a27d54deead2bf01b32920f051a0a5130e01',
     armv7l: 'bc8b6a89a22f628c041aaf09f751a27d54deead2bf01b32920f051a0a5130e01',
       i686: '758be96fddb653a4e4312f1bfa7d216cdb45e3621315bb632915422be2fc6b56',
     x86_64: 'a22d8af293c2ba8f2bb7c19d53122d25d1837d11985daed7598b916c3d8ca927'
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
