require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.0.1-1'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.1.tar.gz'
  source_sha256 '369825db2199f6aeef16b408df6a04ebaddb664fb9af0ec8c686b0ce7ab77727'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.1-1_armv7l/ruby-3.0.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.1-1_armv7l/ruby-3.0.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.1-1_i686/ruby-3.0.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.1-1_x86_64/ruby-3.0.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '03f443d63cca0fb640ec4d11f3b1306a9719e775f8c706c732f9231e41e66afd',
     armv7l: '03f443d63cca0fb640ec4d11f3b1306a9719e775f8c706c732f9231e41e66afd',
       i686: 'dc388589df39c39e9c494e761ae2ca950a9b4f0573aa0d96508959787c050dcd',
     x86_64: '4f86c98eaae1e708bf66f1c939a5cd07d5764b9b64ca827e6f7d5f61021bcb7e'
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
