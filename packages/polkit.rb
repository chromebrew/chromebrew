require 'package'

class Polkit < Package
  description 'Application development toolkit for controlling system-wide privileges'
  homepage 'https://www.freedesktop.org/wiki/Software/polkit/'
  version '0.120-a2bf5c'
  license 'LGPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/polkit/polkit.git'
  git_hashtag 'a2bf5c9c83b6ae46cbd5c779d3055bff81ded683'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '64f33f2ac0ab70d6aef5e1678bd83a5dbd9487ae50641402ffc5bd049409b4bf',
     armv7l: '64f33f2ac0ab70d6aef5e1678bd83a5dbd9487ae50641402ffc5bd049409b4bf',
     x86_64: '7b775cbb16b44bde17a539955b33e14f97146ba10237ebeb01ec2ea700acafc7'
  })

  depends_on 'duktape'
  depends_on 'elogind'
  depends_on 'gtk_doc' => :build
  depends_on 'gobject_introspection' => :build

  def self.patch
    # Fix meson 0.60+ compatibility
    # https://gitlab.freedesktop.org/polkit/polkit/-/merge_requests/99
    @polkit_meson_patch = <<~POLKIT_MESON_PATCH_HEREDOC
      diff --git a/actions/meson.build b/actions/meson.build
      index 2abaaf3..1e3f370 100644
      --- a/actions/meson.build
      +++ b/actions/meson.build
      @@ -1,7 +1,6 @@
       policy = 'org.freedesktop.policykit.policy'

       i18n.merge_file(
      -  policy,
         input: policy + '.in',
         output: '@BASENAME@',
         po_dir: po_dir,
      diff --git a/src/examples/meson.build b/src/examples/meson.build
      index c6305ab..8c18de5 100644
      --- a/src/examples/meson.build
      +++ b/src/examples/meson.build
      @@ -1,7 +1,6 @@
       policy = 'org.freedesktop.policykit.examples.pkexec.policy'

       i18n.merge_file(
      -  policy,
         input: policy + '.in',
         output: '@BASENAME@',
         po_dir: po_dir,
    POLKIT_MESON_PATCH_HEREDOC
    File.write('99.patch', @polkit_meson_patch)
    system 'patch -F3 -Np1 -i 99.patch'
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dsession_tracking=libelogind \
    -Dsystemdsystemunitdir=#{CREW_PREFIX}/etc/elogind/ \
    -Djs_engine=duktape \
    -Dos_type=gentoo \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
