require 'package'
require_relative 'llvm18_build'

class Llvm18_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm18_build.homepage
  version '18.1.4'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib* and llvm_dev* in tandem.
  puts "#{self} version differs from llvm version #{Llvm18_build.version}".orange if version != Llvm18_build.version
  license Llvm18_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '167e1e61c6b6f628fa50ae0999d58370f3e99b422e4665287e546493c1d145ed',
     armv7l: '167e1e61c6b6f628fa50ae0999d58370f3e99b422e4665287e546493c1d145ed',
       i686: '3fc9763fc0dd61120b85fe858c080ab74b268891381136a8b90dc91034ad4d3b',
     x86_64: 'd78d0d0871347162cd3f7a654d30f50e08c4c74f35c45a5123c0ede9fe9742ec'
  })

  depends_on 'gcc_dev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'llvm18_build' => :build
  depends_on 'llvm18_lib' # R
  depends_on 'ncurses' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm18_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm18_build.filelist')
    abort 'File list for llvm18_build does not exist!'.lightred unless File.file?(@filelist_path)
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
