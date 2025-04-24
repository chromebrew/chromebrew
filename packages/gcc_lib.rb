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
  version "15.1.0-RC-20250423-glibc#{@gcc_libc_version}" # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  case @gcc_libc_version
  when '2.23'

    binary_sha256({
         i686: '373c699eba4b866873f62f9bc6c815b3df6f3da826ae35cabebbbe7da38892db'
    })
  when '2.27', '2.32', '2.33', '2.35', '2.37'

    binary_sha256({
      aarch64: 'aeaa24acdaa1301bd53490e88375d13b54d020c94a07bc44f570aeeafdc72ded',
       armv7l: 'aeaa24acdaa1301bd53490e88375d13b54d020c94a07bc44f570aeeafdc72ded',
       x86_64: '28debdd2cb26df240cfa3529f40695c26b47c6ded9dfe9a8c8457097ce406171'
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
