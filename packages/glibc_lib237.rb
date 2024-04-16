require 'package'
require_relative 'glibc_build235'

class Glibc_lib237 < Package
  description 'glibc libraries'
  homepage Glibc_build235.homepage
  version '2.37' # Do not use @_ver here, it will break the installer.
  license Glibc_build235.license
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '877f6ce14ccdbf7ca103a0e131d40a1f91654183599812b4917eae7cfce37550',
     armv7l: '877f6ce14ccdbf7ca103a0e131d40a1f91654183599812b4917eae7cfce37550',
     x86_64: '66d0971a2fbf1b69c7030ba7a8bde986baeef38870ee13606d16f381f16a551a'
  })

  depends_on 'glibc_build237' => :build
  # depends_on 'glibc' # R
  # depends_on 'glibc_lib' # R

  conflicts_ok
  no_source_build
  no_upstream_update

  # def self.preflight
   #  abort 'Glibc_lib requires glibc = 2.37.' unless Gem::Version.new(LIBC_VERSION.to_s) == Gem::Version.new('2.37')
  # end

  def self.install
    puts 'Installing Glibc_build237 to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'glibc_build237.filelist')
    abort 'File list for Glibc_build237 does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless filename.include?('.so') || filename.include?('bin/')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
