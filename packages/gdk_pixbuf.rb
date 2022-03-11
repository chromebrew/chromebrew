require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  @_ver = '2.42.6'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gdk-pixbuf.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdk_pixbuf/2.42.6-1_armv7l/gdk_pixbuf-2.42.6-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdk_pixbuf/2.42.6-1_armv7l/gdk_pixbuf-2.42.6-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdk_pixbuf/2.42.6-1_i686/gdk_pixbuf-2.42.6-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdk_pixbuf/2.42.6-1_x86_64/gdk_pixbuf-2.42.6-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1c577ba59a852aaaffd4612ef72396b2d37f44c3cf81fcee85376b8b14b3bb7f',
     armv7l: '1c577ba59a852aaaffd4612ef72396b2d37f44c3cf81fcee85376b8b14b3bb7f',
       i686: '4aa97c61517ec11c151336b3a9ec9cd64db27f79bff70f321b0807effd5f663e',
     x86_64: '441ce2ef5883ca7f98671f44498cc66f7f2be344473fd911c307d06c794e0f0f'
  })

  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libjpeg' # R
  # depends_on 'libtiff' # R This drags gtk3 into the deps via libwebp
  # depends_on 'libwebp' => :build This drags gtk3 into the deps.
  depends_on 'pango' => :build
  depends_on 'py3_markdown' => :build
  depends_on 'py3_six' => :build
  depends_on 'py3_typogrify' => :build

  def self.patch
    @gif_overflow_patch = <<~'PATCH_EOF'
      From 0cf97225c9c227d11fc4ddf9cba8e8480672ee1b Mon Sep 17 00:00:00 2001
      From: Robert Ancell <robert.ancell@canonical.com>
      Date: Wed, 2 Feb 2022 12:38:45 +1300
      Subject: [PATCH 2/4] Add an assertion that checks for maximum LZW code size

      ---
       gdk-pixbuf/lzw.c | 2 ++
       1 file changed, 2 insertions(+)

      diff --git a/gdk-pixbuf/lzw.c b/gdk-pixbuf/lzw.c
      index 105daf2b1..15293560b 100644
      --- a/gdk-pixbuf/lzw.c
      +++ b/gdk-pixbuf/lzw.c
      @@ -121,6 +121,8 @@ lzw_decoder_new (guint8 code_size)
               LZWDecoder *self;
               int i;
       
      +        g_return_val_if_fail (code_size <= LZW_CODE_MAX, NULL);
      +
               self = g_object_new (lzw_decoder_get_type (), NULL);
       
               self->min_code_size = code_size;
      -- 
      GitLab


      From 19ebba03117aefc9d0312f675f3a210ffdcc4907 Mon Sep 17 00:00:00 2001
      From: Robert Ancell <robert.ancell@canonical.com>
      Date: Wed, 2 Feb 2022 14:03:13 +1300
      Subject: [PATCH 3/4] Fix the check for maximum value of LZW initial code size.

      This value is the number of bits for each symbol (i.e. colour index) decoded via LZW.
      The maximum LZW code is specified as 12 bits, so the value here can only be 11 as two additional code words are required (clear and end of information) that immediately uses an additional bit.
      This implementation has always been wrong, and the Firefox implementation has the same issue so it seems a common misinterpretation of the spec.
      This has been changed here to avoid an assertion later in the LZW decoder.
      Note that there is never any reason for a GIF to be encoded with more than 8 bits of colour information, as the colour tables only support up to 8 bits.
      ---
       gdk-pixbuf/io-gif.c | 4 ++--
       1 file changed, 2 insertions(+), 2 deletions(-)

      diff --git a/gdk-pixbuf/io-gif.c b/gdk-pixbuf/io-gif.c
      index 1befba155..310bdff6a 100644
      --- a/gdk-pixbuf/io-gif.c
      +++ b/gdk-pixbuf/io-gif.c
      @@ -499,8 +499,8 @@ gif_prepare_lzw (GifContext *context)
       		/*g_message (_("GIF: EOF / read error on image data\n"));*/
       		return -1;
       	}
      -        
      -        if (context->lzw_set_code_size > 12) {
      +
      +        if (context->lzw_set_code_size >= 12) {
                       g_set_error_literal (context->error,
                                            GDK_PIXBUF_ERROR,
                                            GDK_PIXBUF_ERROR_CORRUPT_IMAGE,
      -- 
      GitLab

    PATCH_EOF
    File.write('gif_overflow.patch', @gif_overflow_patch)
    system 'patch -p1 -i gif_overflow.patch || true'
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dinstalled_tests=false \
      -Dbuiltin_loaders=all \
      -Drelocatable=true \
      -Ddebug=false \
      -Dgtk_doc=false \
      -Dman=true \
      builddir"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    loader_dir = "#{CREW_DEST_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders"
    FileUtils.mkdir_p loader_dir
    system "touch #{loader_dir}.cache"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @gdk_pixbuf_env = <<~GDK_PIXBUF_ENV_EOF
      # gdk-pixbuf configuration
      export GDK_PIXBUF_MODULEDIR=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders
      export GDK_PIXBUF_MODULE_FILE=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache
    GDK_PIXBUF_ENV_EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/gdk_pixbuf", @gdk_pixbuf_env)
  end

  def self.postinstall
    system "env GDK_PIXBUF_MODULEDIR=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders \
      GDK_PIXBUF_MODULE_FILE=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache \
      LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} gdk-pixbuf-query-loaders --update-cache"
  end
end
