require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.0.3'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.3.tar.gz'
  source_sha256 '3586861cb2df56970287f0fd83f274bd92058872d830d15570b36def7f1a92ac'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.3_armv7l/ruby-3.0.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.3_armv7l/ruby-3.0.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.3_i686/ruby-3.0.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.3_x86_64/ruby-3.0.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2ca59bc65bfcdc4fcf7c2626c76b99a5cf9647620818534e129f81eff02ee041',
     armv7l: '2ca59bc65bfcdc4fcf7c2626c76b99a5cf9647620818534e129f81eff02ee041',
       i686: '13db0c964a9a23f0db69fea818c9f37910c20170e75eb2e334ed17b6fb0e9f74',
     x86_64: '048b39185f15fa3626c45ab2e9505cedabf33baff853bd57cee5c387b298a44c'
  })

  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    # The download from ruby-lang.org doesn't need autoconf run,
    # but the download from github does.
    system '[ -x configure ] || autoreconf -fiv'
    system "env RUBY_CONF_ENV='stack_protector=no' \
    CFLAGS='-ltinfow -flto=auto' CXXFLAGS='-flto=auto' \
    LDFLAGS='-flto=auto' \
    optflags='-flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --enable-shared \
    --disable-fortify-source"
    system 'make'
  end

  # def self.check
  #  system 'make check || true'
  # end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system 'gem update --silent -N --system'
  end
end
