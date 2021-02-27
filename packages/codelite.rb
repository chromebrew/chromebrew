require 'package'

class Codelite < Package
  description 'CodeLite is an open source, free, cross platform IDE specialized in C, C++, PHP and JavaScript'
  homepage 'https://codelite.org/'
  version '13.0-1'
  compatibility 'all'
  source_url 'https://github.com/eranif/codelite/archive/13.0.tar.gz'
  source_sha256 'f2653fa42d6214999718236998cb223e6de00a498c0cfde795e901be693fb9ac'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/codelite-13.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/codelite-13.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/codelite-13.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/codelite-13.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3ce2928e3a9d72d9a46c90260a6d5b4396913dcdb02a7c8342acebeb5db5c9e0',
     armv7l: '3ce2928e3a9d72d9a46c90260a6d5b4396913dcdb02a7c8342acebeb5db5c9e0',
       i686: 'c3b273b5ed85b711e8d7040ae55142b8f9d92f3a0aad6ec4c09f89b179130b51',
     x86_64: '8a3cb05597521854499fd7f69287ed82a68853a11bda85621c16456b1dc1c081'
  })

  depends_on 'webkit2gtk'
  depends_on 'hunspell'
  depends_on 'libssh'
  depends_on 'wxwidgets'
  depends_on 'sommelier'
  depends_on 'harfbuzz'

  def self.patch
    system "for f in \$(grep -rn '\"/usr\"' | grep set | cut -d':' -f1 | sort | uniq); do sed -i 's,/usr,#{CREW_PREFIX},' \$f; done"
    # As per https://github.com/eranif/codelite/issues/2292
    @gtk3patch = <<~PATCH_EOF
            From 92ed90e07774dfc8556bee02c66120eed4938a40 Mon Sep 17 00:00:00 2001
            From: dghart <dghart david@4Pane.co.uk>
            Date: Wed, 19 Jun 2019 11:23:38 +0100
            Subject: [PATCH] Compilation fix for wx3.0 gtk+3 builds
      #{'      '}
            ---
             codelite_terminal/TextView.cpp | 12 ++++++++++++
             1 file changed, 12 insertions(+)
      #{'      '}
            diff --git a/codelite_terminal/TextView.cpp b/codelite_terminal/TextView.cpp
            index 83d2e260c..5966f9972 100644
            --- a/codelite_terminal/TextView.cpp
            +++ b/codelite_terminal/TextView.cpp
            @@ -12,7 +12,11 @@ TextView::TextView(wxWindow* parent, wxWindowID winid)
                 m_ctrl->SetCaretStyle(wxSTC_CARETSTYLE_BLOCK);
                 m_ctrl->SetYCaretPolicy(wxSTC_CARET_STRICT | wxSTC_CARET_SLOP, 4);
                 m_ctrl->SetLexer(wxSTC_LEX_CONTAINER);
            +#if wxCHECK_VERSION(3, 1, 1)
                 m_ctrl->StartStyling(0);
            +#else
            +    m_ctrl->StartStyling(0, 0x1f);
            +#endif
                 m_ctrl->SetWrapMode(wxSTC_WRAP_CHAR);
             #else
                 m_ctrl = new TextCtrl_t(this, wxID_ANY, "", wxDefaultPosition, wxDefaultSize,
            @@ -61,7 +65,11 @@ void TextView::SetDefaultStyle(const wxTextAttr& attr)
             {
             #if USE_STC
                 m_defaultAttr = attr;
            +#if wxCHECK_VERSION(3, 1, 1)
                 m_ctrl->StartStyling(m_ctrl->GetLastPosition());
            +#else
            +    m_ctrl->StartStyling(m_ctrl->GetLastPosition(), 0x1f);
            +#endif
             #else
                 m_ctrl->SetDefaultStyle(attr);
             #endif
            @@ -210,6 +218,10 @@ void TextView::Clear()
             #if USE_STC
                 m_ctrl->ClearAll();
                 m_ctrl->ClearDocumentStyle();
            +#if wxCHECK_VERSION(3, 1, 1)
                 m_ctrl->StartStyling(0);
            +#else
            +    m_ctrl->StartStyling(0, 0x1f);
            +#endif
             #endif
             }
    PATCH_EOF
    IO.write('codelite_gtk3.patch', @gtk3patch)
    system 'patch -p 1 -i codelite_gtk3.patch'
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CC=clang CXX=clang++ LD=ld.lld \
        CFLAGS='-pipe -flto=thin -fuse-ld=lld' \
        CXXFLAGS='-pipe -flto=thin -isystem #{CREW_PREFIX}/include/harfbuzz -fuse-ld=lld' \
        LDFLAGS='-flto=thin' \
        cmake -G Ninja \
        -DENABLE_LLDB=1 \
        #{CREW_CMAKE_OPTIONS} \
         .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
