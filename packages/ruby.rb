require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  @_ver = '3.1.2'
  version "#{@_ver}-2"
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  git_hashtag "v#{@_ver.tr('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-2_armv7l/ruby-3.1.2-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-2_armv7l/ruby-3.1.2-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-2_i686/ruby-3.1.2-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-2_x86_64/ruby-3.1.2-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6a7f6815e3c945afa520415d82caed3a277af294d323713ff3d3afb2e9201374',
     armv7l: '6a7f6815e3c945afa520415d82caed3a277af294d323713ff3d3afb2e9201374',
       i686: '8c1c82df986e4038b1c6e4a17d1807542e336c0517269f5398351dc896ab2343',
     x86_64: '70bae7cde10fadde59f6b2ab5c2017fdfa390385820a4154df49533527b6e3ff'
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

  def self.build
    system '[ -x configure ] || autoreconf -fiv'
    system "RUBY_TRY_CFLAGS='stack_protector=no' \
      RUBY_TRY_LDFLAGS='stack_protector=no' \
      optflags='-flto' \
      ./configure #{CREW_OPTIONS} \
      --enable-shared \
      --disable-fortify-source"
    system "make"
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
