require 'buildsystems/autotools'

class Mutt < Autotools
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '2.4.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/muttmua/mutt.git'
  git_hashtag "mutt-#{version.gsub('.', '-')}-rel"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77c8d3fb7ec64e3ccd327f4d27202e3bfaa5e5b15834c86eeda340db0da1dd92',
     armv7l: '77c8d3fb7ec64e3ccd327f4d27202e3bfaa5e5b15834c86eeda340db0da1dd92',
       i686: 'e90ef9aa81f3b921b0a61fe70f7ce42f0885a51dff5caab7d22a5c376aee7e42',
     x86_64: '1861365750a8d8c3bf193d1c1c7a1c9ce471bf40faa57386bb6678f0afe9c06d'
  })

  depends_on 'gdbm' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
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
