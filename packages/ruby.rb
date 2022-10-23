require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.1.3-9fc7df7'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby/archive/9fc7df7504f41a7f370e62a004c3fc0abc439295.zip'
  source_sha256 '2c8e6f1f8a6185629f7783e7a9a8c28f98b1ca41450f24fd0f98bf171a6de60a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.3-9fc7df7_armv7l/ruby-3.1.3-9fc7df7-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.3-9fc7df7_armv7l/ruby-3.1.3-9fc7df7-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.3-9fc7df7_i686/ruby-3.1.3-9fc7df7-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.3-9fc7df7_x86_64/ruby-3.1.3-9fc7df7-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e5c31e18f8771a1cbf641adb400cdfecdd05a44167ea5d353c0916f3fb2ab12b',
     armv7l: 'e5c31e18f8771a1cbf641adb400cdfecdd05a44167ea5d353c0916f3fb2ab12b',
       i686: 'ab2315e481abb83214b7321fc2274f861a6b9e0d8f07633b871d13c0f2912328',
     x86_64: '596e3e7e81683a40ef470d6059b1cb679c90311af164a86e29f0008e0df2ee45'
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
  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems

  # at run-time, system's gmp, openssl, readline and zlibpkg can be used

  no_patchelf
  no_zstd

  def self.build
    system '[ -x configure ] || autoreconf -fiv'
    system "RUBY_TRY_CFLAGS='stack_protector=no' \
      RUBY_TRY_LDFLAGS='stack_protector=no' \
      optflags='-flto -fuse-ld=#{CREW_LINKER}' \
      ./configure #{CREW_OPTIONS} \
      --enable-shared \
      --disable-fortify-source"
    system 'make'
  end

  def self.check
    # Do not run checks if rebuilding current ruby version.
    # RUBY_VERSION is a built-in ruby constant.
    system 'make check || true' unless RUBY_VERSION == @_ver
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Gems are stored in a ruby majorversion.minorversion.0 folder.
    @gemrc = <<~GEMRCEOF
      gem: --no-document
      gempath: #{CREW_LIB_PREFIX}/ruby/gems/#{RUBY_VERSION.rpartition('.')[0]}.0
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
