require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.2.2-1' # Do not use @_ver here, it will break the installer.
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/3.2/ruby-3.2.2.tar.gz'
  source_sha256 '96c57558871a6748de5bc9f274e93f4b5aad06cd8f37befa0e8d94e7b8a423bc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.2.2-1_armv7l/ruby-3.2.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.2.2-1_armv7l/ruby-3.2.2-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.2.2-1_i686/ruby-3.2.2-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.2.2-1_x86_64/ruby-3.2.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b789a4b64e009303002774e3d9bdc84de1765e6d9bbc785aa648ff307ad80945',
     armv7l: 'b789a4b64e009303002774e3d9bdc84de1765e6d9bbc785aa648ff307ad80945',
       i686: '0c909907312c3404c4665cf8c09f8125dc19f5c74a173158cb3d9b62af1d8dcd',
     x86_64: '6f3aaa3fb45ef6d5d691b9a53262aeee687e00dfcdfb5cb9771c3dfaa1b17684'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'filecmd' # L (This is to enable file command use in package files.)
  depends_on 'gmp' # R
  depends_on 'gcc_lib' # R
  depends_on 'libffi' # R
  depends_on 'openssl' # R
  depends_on 'libyaml' # R
  depends_on 'readline' # R
  depends_on 'rust' => :build
  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems

  # at run-time, system's gmp, openssl, readline and zlibpkg can be used

  def self.patch
    # Get the 1.71 version of fileutils, which is not in Ruby 3.2.2.
    downloader 'https://github.com/ruby/fileutils/raw/7138d851562688267f6dc064fbceca72cb96a53e/lib/fileutils.rb',
               'c758e5c1967ec8841930fe42c7ac7bc26db72e28f208b9b175a6b6074002afe1', 'lib/fileutils.rb'
  end

  def self.build
    @yjit = ARCH == 'x86_64' ? '--enable-yjit' : ''
    system '[ -x configure ] || autoreconf -fiv'
    system "RUBY_TRY_CFLAGS='stack_protector=no' \
      RUBY_TRY_LDFLAGS='stack_protector=no' \
      optflags='-flto=auto -fuse-ld=#{CREW_LINKER}' \
      mold -run ./configure #{CREW_OPTIONS} \
      --enable-shared \
      #{@yjit} \
      --disable-fortify-source"
    system "MAKEFLAGS='--jobs #{CREW_NPROC}' make"
  end

  def self.check
    # Do not run checks if rebuilding current ruby version.
    # RUBY_VERSION is a built-in ruby constant.
    system "MAKEFLAGS='--jobs #{CREW_NPROC}' make check || true" unless version.split('-')[0] == RUBY_VERSION
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Gems are stored in a ruby majorversion.minorversion.0 folder.
    @gemrc = <<~GEMRCEOF
      gem: --no-document
      gempath: #{CREW_LIB_PREFIX}/ruby/gems/3.2.0
    GEMRCEOF
    FileUtils.mkdir_p CREW_DEST_HOME
    File.write("#{CREW_DEST_HOME}/.gemrc", @gemrc)
  end

  def self.postinstall
    puts 'Updating ruby gems. This may take a while...'
    silent = @opt_verbose ? '' : '--silent'
    system "gem update #{silent} -N --system", exception: false
  end
end
