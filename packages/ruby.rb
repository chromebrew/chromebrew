require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.1.1'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  git_hashtag "v#{version.tr('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.1_armv7l/ruby-3.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.1_armv7l/ruby-3.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.1_i686/ruby-3.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.1_x86_64/ruby-3.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3d929442ae74fbbeef4697c2fd16ce7b942847a91cfffada61d8cf42fe23b54c',
     armv7l: '3d929442ae74fbbeef4697c2fd16ce7b942847a91cfffada61d8cf42fe23b54c',
       i686: 'fe5e320182698789dcadf8afdf18c9e3e249e77e3717c1bb6a8cf82419247982',
     x86_64: '6ffc2c0304526000b3ebefb1f653b27f1e449dd9dc5e0a6a2ed762aaca85398d'
  })

  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use
  no_env_options

  def self.build
    # mold is not working with the ruby build for both i686 and x86_64
    @crew_linker = 'gold'
    system '[ -x configure ] || autoreconf -fiv'
    system "LD=ld.#{@crew_linker} \
    RUBY_TRY_CFLAGS='stack_protector=no' \
    RUBY_TRY_LDFLAGS='stack_protector=no' \
    CFLAGS='-flto -fuse-ld=#{@crew_linker} #{CREW_LINKER_FLAGS}' \
    CXXFLAGS='-flto -fuse-ld=#{@crew_linker} #{CREW_LINKER_FLAGS}' \
    LDFLAGS='-flto' \
    optflags='-flto' \
    ./configure #{CREW_OPTIONS} \
    --enable-shared \
    --disable-fortify-source"
    system "LD=ld.#{@crew_linker} make"
  end

  def self.check
    system 'make check || true'
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
