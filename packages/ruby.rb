require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.1.2'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  git_hashtag "v#{version.tr('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2_armv7l/ruby-3.1.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2_armv7l/ruby-3.1.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2_i686/ruby-3.1.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2_x86_64/ruby-3.1.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ecdc85c4e4e790de310c8fcc8550ea29f8c842e782e5fc6abb6ef516b89c066f',
     armv7l: 'ecdc85c4e4e790de310c8fcc8550ea29f8c842e782e5fc6abb6ef516b89c066f',
       i686: '60c190389e21bdffb689ddb62220dcc96a94c9200428124dd2e0303d09954252',
     x86_64: 'b4b9564d4c67ad01096e401bf654535025cd9c274b0faeedc8a4d53906046f47'
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
