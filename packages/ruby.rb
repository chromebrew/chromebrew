require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.2.2' # Do not use @_ver here, it will break the installer.
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/3.2/ruby-3.2.2.tar.gz'
  source_sha256 '96c57558871a6748de5bc9f274e93f4b5aad06cd8f37befa0e8d94e7b8a423bc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.2.2_armv7l/ruby-3.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.2.2_armv7l/ruby-3.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.2.2_i686/ruby-3.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.2.2_x86_64/ruby-3.2.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '338fea592e14496eca2c7548e82f369b52023093752bc367383c756930d8ed61',
     armv7l: '338fea592e14496eca2c7548e82f369b52023093752bc367383c756930d8ed61',
       i686: '83e0bcca62a66caf56627dc6dcc654722622a213ab19e906334249c9bd271a61',
     x86_64: 'df20653dd55995dc3c880bc777b50752d08cdaee8a8eaa245ed6f207b9a7e7d0'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'filecmd' # L (This is to enable file command use in package files.)
  depends_on 'gmp' # R
  depends_on 'gcc' # R
  depends_on 'libffi' # R
  depends_on 'openssl' # R
  depends_on 'libyaml' # R
  depends_on 'readline' # R
  depends_on 'rust' => :build
  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems

  # at run-time, system's gmp, openssl, readline and zlibpkg can be used

  no_patchelf
  no_zstd

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
      ./configure #{CREW_OPTIONS} \
      --enable-shared \
      #{@yjit} \
      --disable-fortify-source"
    system 'make'
  end

  def self.check
    # Do not run checks if rebuilding current ruby version.
    # RUBY_VERSION is a built-in ruby constant.
    system 'make check || true' unless version == RUBY_VERSION
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
