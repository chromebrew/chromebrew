require 'package'

class Libcanberra < Package
  description 'XDG Sound Theme and Name Specification library implementation'
  homepage 'http://0pointer.de/lennart/projects/libcanberra/'
  version '0.30-1'
  compatibility 'all'
  source_url 'http://pkgs.fedoraproject.org/repo/pkgs/libcanberra/libcanberra-0.30.tar.xz/34cb7e4430afaf6f447c4ebdb9b42072/libcanberra-0.30.tar.xz'
  source_sha256 'c2b671e67e0c288a69fc33dc1b6f1b534d07882c2aceed37004bf48c601afa72'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcanberra-0.30-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcanberra-0.30-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcanberra-0.30-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcanberra-0.30-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2a8d173a95f304fdfe202184fbf842d0f5f543a273c18df91bfd52109d16d8ca',
     armv7l: '2a8d173a95f304fdfe202184fbf842d0f5f543a273c18df91bfd52109d16d8ca',
       i686: '36b8c4286a7309c8338f142296bb5e386e92371bb8eb2758c2ee2b2d1c9ae353',
     x86_64: '8fb64b8552e9340a97fe1eaae7ca4f8326dcb4bcc534737847c9b151c3876fcf'
  })

  depends_on 'pygtk'
  depends_on 'libvorbis'
  depends_on 'gstreamer'
  depends_on 'alsa_lib'
  depends_on 'tdb'
  depends_on 'pulseaudio'
  depends_on 'eudev'
  depends_on 'vala'

  def self.patch
    # via https://github.com/jgibbons94/stable-guix/commit/ec82d58526c27a9ca26f6c5e39cec90a48cbc1cc
    @libcanberra_wayland_crash_patch = <<~LIBCANBERRA_WAYLAND_PATCH_HEREDOC
            # This patch comes from upstream commit c0620e432650e81062c1967cc669829dbd29b310.
            # gtk: Don't assume all GdkDisplays are GdkX11Displays: broadway/wayland
      #{'      '}
            --- src/canberra-gtk-module.c.orig
            +++ src/canberra-gtk-module.c
            @@ -307,6 +307,11 @@ static gint window_get_desktop(GdkDisplay *d, GdkWindow *w) {
                     guchar *data = NULL;
                     gint ret = -1;
      #{'       '}
            +#ifdef GDK_IS_X11_DISPLAY
            +        if (!GDK_IS_X11_DISPLAY(d))
            +                return 0;
            +#endif
            +
                     if (XGetWindowProperty(GDK_DISPLAY_XDISPLAY(d), GDK_WINDOW_XID(w),
                                            gdk_x11_get_xatom_by_name_for_display(d, "_NET_WM_DESKTOP"),
                                            0, G_MAXLONG, False, XA_CARDINAL, &type_return,
            @@ -335,6 +340,11 @@ static gint display_get_desktop(GdkDisplay *d) {
                     guchar *data = NULL;
                     gint ret = -1;
      #{'       '}
            +#ifdef GDK_IS_X11_DISPLAY
            +        if (!GDK_IS_X11_DISPLAY(d))
            +                return 0;
            +#endif
            +
                     if (XGetWindowProperty(GDK_DISPLAY_XDISPLAY(d), DefaultRootWindow(GDK_DISPLAY_XDISPLAY(d)),
                                            gdk_x11_get_xatom_by_name_for_display(d, "_NET_CURRENT_DESKTOP"),
                                            0, G_MAXLONG, False, XA_CARDINAL, &type_return,
            @@ -365,6 +375,11 @@ static gboolean window_is_xembed(GdkDisplay *d, GdkWindow *w) {
                     gboolean ret = FALSE;
                     Atom xembed;
      #{'       '}
            +#ifdef GDK_IS_X11_DISPLAY
            +        if (!GDK_IS_X11_DISPLAY(d))
            +                return FALSE;
            +#endif
            +
                     /* Gnome Panel applets are XEMBED windows. We need to make sure we
                      * ignore them */
      #{'       '}
            --- src/canberra-gtk.c.orig
            +++ src/canberra-gtk.c
            @@ -185,6 +185,11 @@ static gint window_get_desktop(GdkDisplay *d, GdkWindow *w) {
                     guchar *data = NULL;
                     gint ret = -1;
      #{'       '}
            +#ifdef GDK_IS_X11_DISPLAY
            +        if (!GDK_IS_X11_DISPLAY(d))
            +                return 0;
            +#endif
            +
                     if (XGetWindowProperty(GDK_DISPLAY_XDISPLAY(d), GDK_WINDOW_XID(w),
                                            gdk_x11_get_xatom_by_name_for_display(d, "_NET_WM_DESKTOP"),
                                            0, G_MAXLONG, False, XA_CARDINAL, &type_return,
    LIBCANBERRA_WAYLAND_PATCH_HEREDOC
    IO.write('libcanberra-wayland-crash.patch', @libcanberra_wayland_crash_patch, perm: 0o555)
    system 'patch -p0 < libcanberra-wayland-crash.patch'
  end

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-alsa \
      --enable-null \
      --disable-lynx \
      --enable-gstreamer \
      --disable-oss \
      --with-builtin=dso"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
