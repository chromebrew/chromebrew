require 'package'

class Neovim < Package
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.7.2'
  license 'Apache-2.0 and vim'
  compatibility 'all'
  source_url 'https://github.com/neovim/neovim.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neovim/0.7.2_armv7l/neovim-0.7.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neovim/0.7.2_armv7l/neovim-0.7.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neovim/0.7.2_i686/neovim-0.7.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neovim/0.7.2_x86_64/neovim-0.7.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ad6d1e50831c384c0095da78f856c9e12e9afc7b19207a81a43f6fd77603cbdb',
     armv7l: 'ad6d1e50831c384c0095da78f856c9e12e9afc7b19207a81a43f6fd77603cbdb',
       i686: '65ee63d50c1a3be1ba44b16e688cec5189f2da3667322040521ca7b0f6a870c5',
     x86_64: 'eca57df7d7ae7376b17d783edd4a1e3bc21ad567263acee44710f3e98c9d4e1b'
  })

  depends_on 'msgpack_c'
  depends_on 'libluv'
  depends_on 'libtermkey'
  depends_on 'libuv'
  depends_on 'libvterm'
  depends_on 'luajit'
  depends_on 'luajit_bitop'
  depends_on 'luajit_lpeg'
  depends_on 'luajit_mpack'
  depends_on 'tree_sitter'
  depends_on 'unibilium'
  depends_on 'xdg_base'

  def self.patch
    # Patch from https://github.com/neovim/neovim/issues/16217#issuecomment-958641608
    @neovimpatch = <<~'PATCH_EOF'
      diff --git a/src/nvim/terminal.c b/src/nvim/terminal.c
      index fb025265f..52d13fe4f 100644
      --- a/src/nvim/terminal.c
      +++ b/src/nvim/terminal.c
      @@ -815,7 +815,7 @@ static int term_settermprop(VTermProp prop, VTermValue *val, void *data)

         case VTERM_PROP_TITLE: {
           buf_T *buf = handle_get_buffer(term->buf_handle);
      -    buf_set_term_title(buf, val->string);
      +    buf_set_term_title(buf, val->string.str);
           break;
         }
    PATCH_EOF
    File.write('neovim.patch', @neovimpatch)
    system 'patch -p 1 -i neovim.patch'
  end

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
        ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
