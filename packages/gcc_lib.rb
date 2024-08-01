require 'package'
Package.load_package("#{__dir__}/gcc_build.rb")

class Gcc_lib < Package
  description 'GCC shared libs except libgccjit'
  homepage Gcc_build.homepage
  version "14.2.0-glibc#{LIBC_VERSION}" # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version (#{version}) differs from gcc version #{Gcc_build.version}".orange if version.to_s != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  case LIBC_VERSION
  when '2.23'
    binary_sha256({
         i686: '4f82296584a31339ea3d6212403cd844cab0e2c150878239c04211112be80181'
    })
  when '2.27', '2.32', '2.33', '2.35'
    binary_sha256({
      aarch64: '6ebddcef4b4ad7f7baf54c9f1e4912906ca36424d39e9ef3cda40466c8028b36',
       armv7l: '6ebddcef4b4ad7f7baf54c9f1e4912906ca36424d39e9ef3cda40466c8028b36',
       x86_64: 'c14b82e8240bc5db1a6634fc33d9405386be19af182f6364e7a318bc9f2714f8'
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
