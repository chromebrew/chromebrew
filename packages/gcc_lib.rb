require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Gcc_lib < Package
  description 'GCC shared libs except libgccjit'
  homepage Gcc_build.homepage
  @gcc_libc_version = if %w[2.23 2.27 2.32 2.33 2.35 2.37].any? { |i| LIBC_VERSION.include? i }
                        LIBC_VERSION
                      else
                        ARCH.eql?('i686') ? '2.23' : '2.27'
                      end
  version "15.1.0-RC-20250418-glibc#{@gcc_libc_version}" # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  case @gcc_libc_version
  when '2.23'

  binary_sha256({
       i686: '3892122f1af8a68fdbf94493d021c82364f3b24174fcdf6b767ec215762ac9b8'
  })
  when '2.27', '2.32', '2.33', '2.35'

  binary_sha256({
    aarch64: '6499c674331e3911225d321663d3d96231831a888ea3a5ff7a83a9fd00832880',
     armv7l: '6499c674331e3911225d321663d3d96231831a888ea3a5ff7a83a9fd00832880',
     x86_64: 'eb126f81f3e25989709626dec83f7e8d62b6d85386b6c697248d6d7d353f2ac2'
  })
  when '2.37'
    binary_sha256({
      aarch64: '98ff61c1fd0d398658b08eaf84141deaa7a6d7b2f0fde5081c583234c0b70448',
       armv7l: '98ff61c1fd0d398658b08eaf84141deaa7a6d7b2f0fde5081c583234c0b70448',
       x86_64: '902d07004020783387b436eaf5f9fb9b9a22da608a73486328871396212f503d'
    })
  end

  depends_on 'gcc_build' => :build
  depends_on 'glibc_lib' # R
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
