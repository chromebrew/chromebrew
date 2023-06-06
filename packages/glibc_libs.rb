require 'package'
require_relative 'glibc'

class Glibc_libs < Package
  description 'glibc libraries'
  homepage Glibc.homepage
  version '2.35' # Do not use @_ver here, it will break the installer.
  license Glibc.license
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc_libs/2.35_armv7l/glibc_libs-2.35-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc_libs/2.35_armv7l/glibc_libs-2.35-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc_libs/2.35_x86_64/glibc_libs-2.35-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '421849e503d19d6a6bc0c755a1d854857e5f227423b3dc3ff81dfd0fc4957689',
     armv7l: '421849e503d19d6a6bc0c755a1d854857e5f227423b3dc3ff81dfd0fc4957689',
     x86_64: '014dddf9cbc8f7b078f59d8f28009bf567ff8b52a757c6bc88b553f994f07c1e'
  })

  depends_on 'glibc' => :build

  conflicts_ok

  def self.preflight
    abort 'Glibc_libs requires glibc = 2.35.' unless Gem::Version.new(LIBC_VERSION.to_s) == Gem::Version.new('2.35')
  end

  def self.install
    puts 'Installing Glibc to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'glibc.filelist')
    abort 'File list for Glibc does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless filename.include?('.so')

      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{filename}"
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
