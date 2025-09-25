require 'buildsystems/meson'

class Elogind < Meson
  description 'Standalone systemd-logind fork'
  homepage 'https://github.com/elogind/elogind'
  version '257-39c31cd'
  license 'CC0-1.0, LGPL-2.1+ and public-domain'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/elogind/elogind.git'
  git_hashtag '39c31cd9b2cdfccdb73cb9a21df5ac731b23a650'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7bf79ff8159f5d90f36c8680f70bb4ad8b36276c0600e4aac664ce79b8808b6e',
     armv7l: '7bf79ff8159f5d90f36c8680f70bb4ad8b36276c0600e4aac664ce79b8808b6e',
     x86_64: 'a12c145e41d5f8691731bf29a3d832f7974fea3e887677b649dbc43ea5888a9a'
  })

  depends_on 'eudev' => :build
  depends_on 'libcap' => :build
  depends_on 'linux_pam' # L
  depends_on 'dbus' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'gperf' => :build
  depends_on 'libxslt' => :build
  depends_on 'shadow' => :build
  depends_on 'glib' => :build
  depends_on 'polkit' => :build
  depends_on 'py3_jinja2' => :build

  meson_options "-Dsplit-bin=false \
      -Dsysconfdir=#{CREW_PREFIX}/etc \
      -Dtranslations=false \
      -Dcgroup-controller=elogind \
      -Dman=enabled \
      -Ddefault-kill-user-processes=false \
      -Dhalt-path=/sbin/halt \
      -Dreboot-path=/sbin/reboot"

  def self.patch
    File.write '062fbb79781c4b1a72ad6256f57bb057da9e426c_reversed_2.patch', <<~PATCH_EOF
      diff -Npaur a/src/basic/pidref.c b/src/basic/pidref.c
      --- a/src/basic/pidref.c	2025-09-24 17:21:55.588116430 -0400
      +++ b/src/basic/pidref.c	2025-09-24 17:22:50.694341034 -0400
      @@ -424,47 +424,6 @@ bool pidref_is_self(const PidRef *pidref
               return pidref->pid == getpid_cached();
       }

      -int pidref_wait(const PidRef *pidref, siginfo_t *ret, int options) {
      -        int r;
      -
      -        if (!pidref_is_set(pidref))
      -                return -ESRCH;
      -
      -        if (pidref_is_remote(pidref))
      -                return -EREMOTE;
      -
      -        if (pidref->pid == 1 || pidref->pid == getpid_cached())
      -                return -ECHILD;
      -
      -        siginfo_t si = {};
      -
      -        if (pidref->fd >= 0) {
      -                r = RET_NERRNO(waitid(P_PIDFD, pidref->fd, &si, options));
      -                if (r >= 0) {
      -                        if (ret)
      -                                *ret = si;
      -                        return r;
      -                }
      -                if (r != -EINVAL) /* P_PIDFD was added in kernel 5.4 only */
      -                        return r;
      -        }
      -
      -        r = RET_NERRNO(waitid(P_PID, pidref->pid, &si, options));
      -        if (r >= 0 && ret)
      -                *ret = si;
      -        return r;
      -}
      -
      -int pidref_wait_for_terminate(const PidRef *pidref, siginfo_t *ret) {
      -        int r;
      -
      -        for (;;) {
      -                r = pidref_wait(pidref, ret, WEXITED);
      -                if (r != -EINTR)
      -                        return r;
      -        }
      -}
      -
       bool pidref_is_automatic(const PidRef *pidref) {
               return pidref && pid_is_automatic(pidref->pid);
       }
      diff -Npaur a/src/basic/pidref.h b/src/basic/pidref.h
      --- a/src/basic/pidref.h	2025-09-24 17:21:55.594783043 -0400
      +++ b/src/basic/pidref.h	2025-09-24 17:24:31.390200859 -0400
      @@ -93,22 +93,11 @@ int pidref_new_from_pid(pid_t pid, PidRe

       int pidref_kill(const PidRef *pidref, int sig);
       int pidref_kill_and_sigcont(const PidRef *pidref, int sig);
      +int pidref_sigqueue(const PidRef *pidfref, int sig, int value);
       #if 0 /// UNNEEDED by elogind
       int pidref_sigqueue(const PidRef *pidref, int sig, int value);
       #endif // 0

      -int pidref_wait(const PidRef *pidref, siginfo_t *siginfo, int options);
      -int pidref_wait_for_terminate(const PidRef *pidref, siginfo_t *ret);
      -
      -static inline void pidref_done_sigkill_wait(PidRef *pidref) {
      -        if (!pidref_is_set(pidref))
      -                return;
      -
      -        (void) pidref_kill(pidref, SIGKILL);
      -        (void) pidref_wait_for_terminate(pidref, NULL);
      -        pidref_done(pidref);
      -}
      -
       int pidref_verify(const PidRef *pidref);

       #define TAKE_PIDREF(p) TAKE_GENERIC((p), PidRef, PIDREF_NULL)
    PATCH_EOF
    system 'patch -Np1 -i 062fbb79781c4b1a72ad6256f57bb057da9e426c_reversed_2.patch'
  end
end
