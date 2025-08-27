require 'package'
Package.load_package("#{__dir__}/llvm21_build.rb")

class Llvm21_dev < Package
  description 'LLVM: Everything except libLLVM & llvm-strip'
  homepage Llvm21_build.homepage
  version '21.1.0'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm21_build.version}".orange if version != Llvm21_build.version
  license Llvm21_build.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3f9c3af1de9a889acc8f4d82ebcde0c033a573a496d4f668b87edbebe25f5fa',
     armv7l: 'a3f9c3af1de9a889acc8f4d82ebcde0c033a573a496d4f668b87edbebe25f5fa',
       i686: '8f88168698f5d798161467be8b4d397ecaf98eb3f2a23f8bff06d3f166b81dc2',
     x86_64: '48a94cdeadaa9205edeaab675536a724a43b96281f62f03a712a24313d84780d'
  })

  binary_sha256({
    aarch64: 'a3f9c3af1de9a889acc8f4d82ebcde0c033a573a496d4f668b87edbebe25f5fa',
     armv7l: 'a3f9c3af1de9a889acc8f4d82ebcde0c033a573a496d4f668b87edbebe25f5fa',
       i686: '8f88168698f5d798161467be8b4d397ecaf98eb3f2a23f8bff06d3f166b81dc2',
     x86_64: '48a94cdeadaa9205edeaab675536a724a43b96281f62f03a712a24313d84780d'
  })

  binary_sha256({
    aarch64: 'a3f9c3af1de9a889acc8f4d82ebcde0c033a573a496d4f668b87edbebe25f5fa',
     armv7l: 'a3f9c3af1de9a889acc8f4d82ebcde0c033a573a496d4f668b87edbebe25f5fa',
       i686: '8f88168698f5d798161467be8b4d397ecaf98eb3f2a23f8bff06d3f166b81dc2',
     x86_64: '48a94cdeadaa9205edeaab675536a724a43b96281f62f03a712a24313d84780d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'libxml2' # R
  depends_on 'llvm21_build' => :build
  depends_on 'llvm_lib' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing llvm21_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm21_build.filelist')
    abort 'File list for llvm21_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next if filename.include?('.so') && filename.include?('libLLVM')
      next if filename.include?('llvm-strip')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
