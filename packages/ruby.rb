require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.1.2-4'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  git_hashtag 'v3_1_2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-4_armv7l/ruby-3.1.2-4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-4_armv7l/ruby-3.1.2-4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-4_i686/ruby-3.1.2-4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-4_x86_64/ruby-3.1.2-4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f4baac3cf547bedef9519071dcb0132b6869c2f9f2500b5bbca5cb8e5ac518bb',
     armv7l: 'f4baac3cf547bedef9519071dcb0132b6869c2f9f2500b5bbca5cb8e5ac518bb',
       i686: '8c61a756a2311f658bdbe024575e2f1c7fefee7e85479b21f2a24e4efedeba75',
     x86_64: 'b6d98ba7d393e88ef14ddc48f45319b754b373c78ab592577f29fd92b1d932ea'
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
  end

  def self.postinstall
    puts 'Updating ruby gems. This may take a while...'
    unless Kernel.system("grep -q \"--no-document\" #{HOME}/.gemrc")
      File.write("#{HOME}/.gemrc", "gem: --no-document\n",
                   mode: 'a')
    end
    unless Kernel.system("grep -q \"gempath\" #{HOME}/.gemrc")
      File.write("#{HOME}/.gemrc", "gempath: #{CREW_LIB_PREFIX}/ruby/gems/3.1.0\n",
                   mode: 'a')
    end
    silent = @opt_verbose ? '' : '--silent'
    system "gem update #{silent} -N --system"
  end
end
