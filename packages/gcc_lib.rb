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
  version "15.1.0-glibc#{@gcc_libc_version}" # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  case @gcc_libc_version
  when '2.23'

  binary_sha256({
       i686: '13540e8567b2b76898be5df457df9dd291c0e1161b4eba4a73a0d80ec841be37'
  })
  when '2.27', '2.32', '2.33', '2.35', '2.37'

    binary_sha256({
    aarch64: 'b84d23e78533f9a4cdefb866370a8bd1d699f50e197d3b567dded7bf5d84a069',
     armv7l: 'b84d23e78533f9a4cdefb866370a8bd1d699f50e197d3b567dded7bf5d84a069',
     x86_64: '2a04de4c08af3532c88f398838e9ea1b71126bf28faf159b101df59b648d676f'
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
