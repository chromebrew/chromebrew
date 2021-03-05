require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.67.5'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  compatibility 'all'
  source_url "https://download.gnome.org/sources/glib/#{@_ver_prelastdot}/glib-#{@_ver}.tar.xz"
  source_sha256 '9d2ad4303ce25ae7cfde77409d8364508ac6072a868cfca2e78333c6cdfa05e6'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'bde7d35943c70e260e52a3688ba88e114717e461bad41b5c90942f46205345c2',
     armv7l: 'bde7d35943c70e260e52a3688ba88e114717e461bad41b5c90942f46205345c2',
       i686: '2ac0cb8ac4a6b92ff84a31f670b1d915b95137d797778ea962fa143dd1c9df81',
     x86_64: '5e5ac89b2b53a90b34da77fe8b26dece4c30c4c772a6232eb229751307bf4cef'
  })

  depends_on 'pcre'
  depends_on 'shared_mime_info'
  depends_on 'util_linux'
  depends_on 'six'
  depends_on 'pygments'

  def self.patch
    # Patch from:
    # https://gitlab.gnome.org/GNOME/glib/-/merge_requests/1958.patch
    @gsubprocesslauncher_patch = <<~GLIB_PATCH_HEREDOC
            From 1e74c52a6349c9c4f265b9b89fffc32730b9cd24 Mon Sep 17 00:00:00 2001
            From: Philip Withnall <pwithnall@endlessos.org>
            Date: Fri, 19 Feb 2021 18:19:53 +0000
            Subject: [PATCH 1/3] gsubprocesslauncher: Improve documentation formatting
             slightly
      #{'      '}
            Signed-off-by: Philip Withnall <pwithnall@endlessos.org>
            ---
             gio/gsubprocesslauncher.c | 8 ++++----
             1 file changed, 4 insertions(+), 4 deletions(-)
      #{'      '}
            diff --git a/gio/gsubprocesslauncher.c b/gio/gsubprocesslauncher.c
            index b7257f453..16c47d542 100644
            --- a/gio/gsubprocesslauncher.c
            +++ b/gio/gsubprocesslauncher.c
            @@ -596,16 +596,16 @@ g_subprocess_launcher_take_stderr_fd (GSubprocessLauncher *self,
              * @target_fd: Target descriptor for child process
              *
              * Transfer an arbitrary file descriptor from parent process to the
            - * child.  This function takes "ownership" of the fd; it will be closed
            + * child.  This function takes ownership of the @source_fd; it will be closed
              * in the parent when @self is freed.
              *
              * By default, all file descriptors from the parent will be closed.
            - * This function allows you to create (for example) a custom pipe() or
            - * socketpair() before launching the process, and choose the target
            + * This function allows you to create (for example) a custom `pipe()` or
            + * `socketpair()` before launching the process, and choose the target
              * descriptor in the child.
              *
              * An example use case is GNUPG, which has a command line argument
            - * --passphrase-fd providing a file descriptor number where it expects
            + * `--passphrase-fd` providing a file descriptor number where it expects
              * the passphrase to be written.
              */
             void
            --#{' '}
            GitLab
      #{'      '}
      #{'      '}
            From 55a75590d0c7e703f32513cc409d6e20a7b761ea Mon Sep 17 00:00:00 2001
            From: Philip Withnall <pwithnall@endlessos.org>
            Date: Fri, 19 Feb 2021 18:20:25 +0000
            Subject: [PATCH 2/3] =?UTF-8?q?gsubprocesslauncher:=20Don=E2=80=99t=20clos?=
             =?UTF-8?q?e=20target=20FDs=20in=20close()=20method?=
            MIME-Version: 1.0
            Content-Type: text/plain; charset=UTF-8
            Content-Transfer-Encoding: 8bit
      #{'      '}
            This is a regression introduced in commit 67a589e505311. Previously, the
            source/target FD pairs were stored in `needdup_fd_assignments`, in
            consecutive entries, so source FDs had even indices and target FDs had
            odd indices.
      #{'      '}
            I didnâ€™t notice that the array index was being incremented by 2 when
            closing FDs, when porting from the old code. So previously the code was
            only closing the source FDs; after the port, it was closing source and
            target FDs.
      #{'      '}
            Thatâ€™s incorrect, as the target FDs are just integers in the parent
            process. Itâ€™s only in the child process where they are actually FDs â€”
            and `g_subprocess_launcher_close()` is never called in the child
            process.
      #{'      '}
            This resulted in some strange misbehaviours in any process which used
            `g_subprocess_launcher_take_fd()` with target FDs which could have
            possibly aliased with other FDs in the parent process (and which werenâ€™t
            equal to their mapped source FDs).
      #{'      '}
            Thanks to Olivier Fourdan for the detailed bug report.
      #{'      '}
            Signed-off-by: Philip Withnall <pwithnall@endlessos.org>
      #{'      '}
            Fixes: #2332
            ---
             gio/gsubprocesslauncher-private.h | 4 ++--
             gio/gsubprocesslauncher.c         | 8 ++++----
             2 files changed, 6 insertions(+), 6 deletions(-)
      #{'      '}
            diff --git a/gio/gsubprocesslauncher-private.h b/gio/gsubprocesslauncher-private.h
            index f8a6516c5..d6fe0d784 100644
            --- a/gio/gsubprocesslauncher-private.h
            +++ b/gio/gsubprocesslauncher-private.h
            @@ -42,8 +42,8 @@ struct _GSubprocessLauncher
               gint stderr_fd;
               gchar *stderr_path;
      #{'       '}
            -  GArray *source_fds;
            -  GArray *target_fds;  /* always the same length as source_fds */
            +  GArray *source_fds;  /* GSubprocessLauncher has ownership of the FD elements */
            +  GArray *target_fds;  /* always the same length as source_fds; elements are just integers and not FDs in this process */
               gboolean closed_fd;
      #{'       '}
               GSpawnChildSetupFunc child_setup_func;
            diff --git a/gio/gsubprocesslauncher.c b/gio/gsubprocesslauncher.c
            index 16c47d542..a1c65e947 100644
            --- a/gio/gsubprocesslauncher.c
            +++ b/gio/gsubprocesslauncher.c
            @@ -661,11 +661,11 @@ g_subprocess_launcher_close (GSubprocessLauncher *self)
                   g_assert (self->target_fds != NULL);
                   g_assert (self->source_fds->len == self->target_fds->len);
      #{'       '}
            +      /* Note: Donâ€™t close the target_fds, as theyâ€™re only valid FDs in the
            +       * child process. This code never executes in the child process. */
                   for (i = 0; i < self->source_fds->len; i++)
            -        {
            -          (void) close (g_array_index (self->source_fds, int, i));
            -          (void) close (g_array_index (self->target_fds, int, i));
            -        }
            +        (void) close (g_array_index (self->source_fds, int, i));
            +
                   g_clear_pointer (&self->source_fds, g_array_unref);
                   g_clear_pointer (&self->target_fds, g_array_unref);
                 }
            --#{' '}
            GitLab
      #{'      '}
      #{'      '}
            From 50cf90dc562d10efa3288357202e8cc04571292c Mon Sep 17 00:00:00 2001
            From: Philip Withnall <pwithnall@endlessos.org>
            Date: Fri, 19 Feb 2021 18:09:42 +0000
            Subject: [PATCH 3/3] =?UTF-8?q?tests:=20Test=20g=5Fsubprocess=5Flauncher?=
             =?UTF-8?q?=5Fclose()=20doesn=E2=80=99t=20close=20too=20many=20FDs?=
            MIME-Version: 1.0
            Content-Type: text/plain; charset=UTF-8
            Content-Transfer-Encoding: 8bit
      #{'      '}
            Expand an existing unit test to check that the target FD of a
            `g_subprocess_launcher_take_fd()` call doesnâ€™t get closed when
            `g_subprocess_launcher_close()` is called. Only the source FD should be
            closed by the parent process.
      #{'      '}
            Signed-off-by: Philip Withnall <pwithnall@endlessos.org>
      #{'      '}
            Helps: #2332
            ---
             gio/tests/gsubprocess.c | 27 ++++++++++++++++++++++++---
             1 file changed, 24 insertions(+), 3 deletions(-)
      #{'      '}
            diff --git a/gio/tests/gsubprocess.c b/gio/tests/gsubprocess.c
            index 3c248e610..7e22678ec 100644
            --- a/gio/tests/gsubprocess.c
            +++ b/gio/tests/gsubprocess.c
            @@ -1494,23 +1494,44 @@ test_subprocess_launcher_close (void)
               GSubprocessLauncher *launcher;
               GSubprocess *proc;
               GPtrArray *args;
            -  int fd;
            +  int fd, fd2;
               gboolean is_open;
      #{'       '}
            -  fd = dup(0);
            +  /* Open two arbitrary FDs. One of them, @fd, will be transferred to the
            +   * launcher, and the otherâ€™s FD integer will be used as its target FD, giving
            +   * the mapping `fd â†’ fd2` if a child process were to be spawned.
            +   *
            +   * The launcher will then be closed, which should close @fd but *not* @fd2,
            +   * as the value of @fd2 is only valid as an FD in a child process. (A child
            +   * process is not actually spawned in this test.)
            +   */
            +  fd = dup (0);
            +  fd2 = dup (0);
               launcher = g_subprocess_launcher_new (G_SUBPROCESS_FLAGS_NONE);
            -  g_subprocess_launcher_take_fd (launcher, fd, fd);
            +  g_subprocess_launcher_take_fd (launcher, fd, fd2);
            +
               is_open = fcntl (fd, F_GETFD) != -1;
               g_assert_true (is_open);
            +  is_open = fcntl (fd2, F_GETFD) != -1;
            +  g_assert_true (is_open);
            +
               g_subprocess_launcher_close (launcher);
            +
               is_open = fcntl (fd, F_GETFD) != -1;
               g_assert_false (is_open);
            +  is_open = fcntl (fd2, F_GETFD) != -1;
            +  g_assert_true (is_open);
            +
            +  /* Now test that actually trying to spawn the child gives %G_IO_ERROR_CLOSED,
            +   * as g_subprocess_launcher_close() has been called. */
               args = get_test_subprocess_args ("cat", NULL);
               proc = g_subprocess_launcher_spawnv (launcher, (const gchar * const *) args->pdata, error);
               g_ptr_array_free (args, TRUE);
               g_assert_null (proc);
               g_assert_error (local_error, G_IO_ERROR, G_IO_ERROR_CLOSED);
               g_clear_error (error);
            +
            +  close (fd2);
               g_object_unref (launcher);
             }
      #{'       '}
            --#{' '}
            GitLab
    GLIB_PATCH_HEREDOC
    IO.write('1958.patch', @gsubprocesslauncher_patch)
    # system 'patch -p1 < 1958.patch'
  end

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dc_args='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
    -Dc_link_args='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
    -Dcpp_args='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
    -Dcpp_link_args='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
    -Das_needed=false \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
