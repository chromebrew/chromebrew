require 'package'
require_relative 'glibc_build237'

class Glibc_lib237 < Package
  description 'glibc libraries'
  homepage Glibc_build237.homepage
  version '2.37' # Do not use @_ver here, it will break the installer.
  license Glibc_build237.license
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e8ea16654e689209ebf82c01cc86808e991ac9b45819c3c6eea993a69967ac1',
     armv7l: '8e8ea16654e689209ebf82c01cc86808e991ac9b45819c3c6eea993a69967ac1',
     x86_64: '56b8c62ab11bc5e1a95bec2ad7e1e64ce7ee07aff7560a720c9a2d937ef42c5e'
  })

  depends_on 'glibc_build237' => :build

  conflicts_ok
  no_shrink
  no_source_build
  no_upstream_update

  def self.preflight
    abort 'Glibc_lib requires glibc = 2.37.' unless Gem::Version.new(LIBC_VERSION.to_s) == Gem::Version.new('2.37')
  end

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
