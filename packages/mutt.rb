require 'buildsystems/autotools'

class Mutt < Autotools
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '2.3.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/muttmua/mutt.git'
  git_hashtag "mutt-#{version.gsub('.', '-')}-rel"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7f41cd6237571c9efffd38840055a47127fd9bdb8be63d856b426957aa644c6',
     armv7l: 'c7f41cd6237571c9efffd38840055a47127fd9bdb8be63d856b426957aa644c6',
       i686: 'cc14601c52e39d2f9d335e68bb2c56ec9c7993ddb1c77883e69931721615ebe6',
     x86_64: '304eb6204e32e75e303abf0fe76930935ee5ece78495d67ede782d039a19bb1f'
  })

  depends_on 'gdbm' => :executable
  depends_on 'glibc' => :executable
  depends_on 'libcyrussasl' => :executable
  depends_on 'libxslt'
  depends_on 'ncurses' => :executable
  depends_on 'openssl' => :executable
  depends_on 'zlib' => :executable

  autotools_configure_options "--with-mailpath=#{CREW_PREFIX}/etc/mail \
    --with-sasl=#{CREW_LIB_PREFIX}/sasl2 \
    --with-ssl \
    --enable-imap \
    --enable-smtp \
    --enable-hcache"

  autotools_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/mail"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/mutt", <<~MUTTEOF
      # Mutt configuration
      SASL_PATH=#{CREW_LIB_PREFIX}/sasl2
    MUTTEOF
  end

  run_tests
end
