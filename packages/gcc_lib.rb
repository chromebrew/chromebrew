require 'package'
require_relative 'gcc_build'

class Gcc_lib < Package
  description 'GCC shared libs except libgccjit'
  homepage Gcc_build.homepage
  version "14.1.0-glibc#{LIBC_VERSION}" # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  case LIBC_VERSION
  when '2.23'
    binary_sha256({
         i686: '192f52beaa24ebbf3e1ae1787c9f12c75ad59e7f7885729d90b7c40b1177d796'
    })
  when '2.27'
    binary_sha256({
      aarch64: '82d95874bc0326967b821420afec5d809c2b883be10bca5798314a4490b11622',
       armv7l: '82d95874bc0326967b821420afec5d809c2b883be10bca5798314a4490b11622',
       x86_64: '3fd1626fa6f4fafe3ce4fceba5b9d0311132d754135c7545a29a042dc3fb91e3'
    })
  when '2.37'
    binary_sha256({
      aarch64: 'aede35bafb5eec105327e8663c06b409e4f13ad662e8e6e472f35fe715dda49c',
       armv7l: 'aede35bafb5eec105327e8663c06b409e4f13ad662e8e6e472f35fe715dda49c',
       x86_64: '0ecf2f8513b209d2f0ee098a3c9dba904d697e23b497e28fef90d07e9ba94277'
    })
  end

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
