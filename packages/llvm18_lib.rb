require 'package'
Package.load_package("#{__dir__}/llvm18_build.rb")

class Llvm18_lib < Package
  description 'LibLLVM and llvm-strip'
  homepage Llvm18_build.homepage
  version '18.1.8'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm18_build.version}".orange if version != Llvm18_build.version
  license Llvm18_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02a4fa4dfe762ccc51e07861d3e0831fb7cb52324838b4b7ce6bb5e273b7e62f',
     armv7l: '02a4fa4dfe762ccc51e07861d3e0831fb7cb52324838b4b7ce6bb5e273b7e62f',
       i686: '614f8f5c65479946aaf20d1ab0930da4990b196b98aebeb1edb0afc58113d8ed',
     x86_64: 'de43c138087ae1a5d33969ff65a4a0f15d6cfc5770212dc9c77adcaea935473b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm18_build' => :build
  depends_on 'ncurses' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm18_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm18_build.filelist')
    abort 'File list for llvm18_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).reject { |line| line.start_with?('#') }

    @filelist.each do |filename|
      next unless (filename.include?('.so') && filename.include?('libLLVM')) || filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
