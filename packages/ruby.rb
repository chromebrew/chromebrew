require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.1.0'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  git_hashtag "v#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.0_armv7l/ruby-3.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.0_armv7l/ruby-3.1.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.0_i686/ruby-3.1.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.0_x86_64/ruby-3.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '584d70c21a759b5a83a7ca0315020f0be8132229687b797cf029f29c1a8bccc5',
     armv7l: '584d70c21a759b5a83a7ca0315020f0be8132229687b797cf029f29c1a8bccc5',
       i686: 'd249ad97ab91d80d256f169233f9e927192624b293a99519c1f2198ceb22d8be',
     x86_64: 'c560190cdc8f41ffb0c90a80652f152fe6ca8ff993940bf845aa98481e866100'
  })

  source_sha256 '1a0e0b69b9b062b6299ff1f6c6d77b66aff3995f63d1d8b8771e7a113ec472e2'

  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.patch
    case ARCH
    when 'i686'
      system "sed -i 's,mingw*|emscripten*,mingw*|emscripten*|linux*,g' configure.ac"
      system "sed -i 's/-fstack-protector-strong//g' configure.ac"
      system "sed -i 's/-fstack-protector/-fno-stack-protector/g' configure.ac"
    end
  end

  def self.build
    # The download from ruby-lang.org doesn't need autoconf run,
    # but the download from github does.
    system '[ -x configure ] || autoreconf -fiv'
    system "CC='gcc -fno-stack-protector' \
    CXX='g++ -fno-stack-protector' \
    RUBY_TRY_CFLAGS='stack_protector=no' \
    RUBY_TRY_LDFLAGS='stack_protector=no' \
    CFLAGS='-ltinfow -flto=auto' CXXFLAGS='-flto=auto' \
    LDFLAGS='-flto=auto' \
    optflags='-flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --enable-shared \
    --disable-fortify-source"
    system 'make'
  end

  def self.check
    system 'make check || true'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts 'Updating ruby gems. This may take a while...'
    if system 'grep', '-q', "gem: --no-document", "#{HOME}/.gemrc"
      File.write("#{HOME}/.gemrc", "gem: --no-document\n", mode: 'a')
    end
    silent = @opt_verbose ? '' : '--silent'
    system "gem update #{silent} -N --system"
  end
end
