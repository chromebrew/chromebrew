require 'buildsystems/autotools'

class Mutt < Autotools
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '2.3.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/muttmua/mutt.git'
  git_hashtag "mutt-#{version.gsub('.', '-')}-rel"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0e2d2afae1a15295ec46d563d92b11f33aede67117a8c3a9b4ac228e2d287b86',
     armv7l: '0e2d2afae1a15295ec46d563d92b11f33aede67117a8c3a9b4ac228e2d287b86',
       i686: 'b83980101ff71a503da2572447c2dae22ae556f0f687e9748eea4791a68d672e',
     x86_64: 'f475ec3ea8014da9cc9182a43e82cf49af376fe24a1132f9bfd0f6da1eb3e5cf'
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
