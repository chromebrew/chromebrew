require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  @_ver = '3.1.2'
  version "#{@_ver}-1"
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  git_hashtag "v#{@_ver.tr('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-1_armv7l/ruby-3.1.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-1_armv7l/ruby-3.1.2-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-1_i686/ruby-3.1.2-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.2-1_x86_64/ruby-3.1.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '83fe8527ef252f66e831b2ac4941722076567e11d89245e0a128cac82d8e3e80',
     armv7l: '83fe8527ef252f66e831b2ac4941722076567e11d89245e0a128cac82d8e3e80',
       i686: 'b730c0bf7e18b8a37e23004a29f2cbd0e6f6aa01e368a5993cb93f0d26a49816',
     x86_64: 'a54b69a20abf4608f6431b762d6ddb0c5cd4a4d0e91bdcb0aedb7dcc0e9175bd'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gcc12' # R
  depends_on 'libffi' # R
  depends_on 'openssl' # R
  depends_on 'libyaml' # R
  depends_on 'readline' # R
  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems
  # at run-time, system's gmp, openssl, readline and zlibpkg can be used

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
