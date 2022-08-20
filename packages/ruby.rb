require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version = '3.1.2-3'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  git_hashtag 'v3_1_2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-3_armv7l/ruby-3.1.2-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-3_armv7l/ruby-3.1.2-3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-3_i686/ruby-3.1.2-3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-3_x86_64/ruby-3.1.2-3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a466a4eed626562b831ece35d10502f3b0816ba81ac7ff3b4c7a04051aa17856',
     armv7l: 'a466a4eed626562b831ece35d10502f3b0816ba81ac7ff3b4c7a04051aa17856',
       i686: '52fb0865ecb00ce46a1f5e58bf39413aaa32683f4dd547d316ac83a1c54a7946',
     x86_64: 'b18f6c4ad3165cc35f25d6089276a7680a4e34bd9dd1ff3fbcd150ba17a8ef7a'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
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
      optflags='-flto -fuse-ld=mold' \
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
    if (File.exist?("#{HOME}/.gemrc") && !Kernel.system("grep -q \"gem: --no-document\" #{HOME}/.gemrc")) || !File.exist?("#{HOME}/.gemrc")
      File.write("#{HOME}/.gemrc", "gem: --no-document\n", mode: 'a')
    end
    silent = @opt_verbose ? '' : '--silent'
    system "gem update #{silent} -N --system"
  end
end
