require 'package'
Package.load_package("#{__dir__}/llvm19_build.rb")

class Llvm19_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm19_build.homepage
  version '19.1.5'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm19_build.version}".orange if version != Llvm19_build.version
  license Llvm19_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ac161456e06445080b3e3d503a06f951a29dc6e6d5599d845691a02fd4b7a21',
     armv7l: '5ac161456e06445080b3e3d503a06f951a29dc6e6d5599d845691a02fd4b7a21',
       i686: 'da65d6c5a34d3953dc37139e7204a75f443257a8ca857a77cf9022300887e285',
     x86_64: '21e06ae9bb1c3ae90749665987b4537e1785f9cec6fceb8126dc3b7d3283bb3f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libxml2' # R
  depends_on 'llvm19_build' => :build
  depends_on 'llvm19_lib' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm19_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm19_build.filelist')
    abort 'File list for llvm19_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next if filename.include?('.so') && filename.include?('libLLVM')
      next if filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
