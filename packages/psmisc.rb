require 'buildsystems/autotools'

class Psmisc < Autotools
  description 'PSmisc is a set of some small useful utilities that use the proc filesystem.'
  homepage 'https://gitlab.com/psmisc/psmisc'
  version '23.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/psmisc/psmisc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd84be50b9c1f15bbd6e547e3b5b323e3218c9e02cd348792afce0106108e09de',
     armv7l: 'd84be50b9c1f15bbd6e547e3b5b323e3218c9e02cd348792afce0106108e09de',
       i686: '09394366ca1f033dfd9e8b9aa50b2d5ccb1dce8334734851f099c63f95ab1fe3',
     x86_64: '29a2b3ed12ece0f873cf335f6bcf5ace47a10ffe26e7582cde0ab451c07c8532'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R

  autotools_pre_configure_options "CFLAGS+=' -I#{CREW_PREFIX}/include/ncurses'"

  def self.patch
    # See: https://gitlab.com/psmisc/psmisc/-/issues/61
    # A partial reversal of https://gitlab.com/psmisc/psmisc/-/commit/7ce4b0af12b19c8fdc00597306973100444a17f4
    # is needed to fix the build.
    File.write 'statx.patch', <<~STATX_PATCH_EOF
      diff -Npaur a/configure.ac b/configure.ac
      --- a/configure.ac	2025-07-05 11:57:29.069916543 -0400
      +++ b/configure.ac	2025-07-05 12:00:16.637833848 -0400
      @@ -62,27 +62,20 @@ if test "$enable_apparmor" = "yes"; then
       fi
       AC_SUBST([DL_LIB])
      #{' '}
      +AC_CHECK_HEADERS([sys/syscall.h])
       AC_CHECK_DECLS([SYS_statx],
         [has_syscall_statx="yes"],
         [has_syscall_statx="no"],
         [[#include <sys/syscall.h>]]
       )
      -
      -# Check for linux specific statx(2) system call
      -AC_CHECK_HEADERS([sys/syscall.h])
       AC_CHECK_FUNCS([statx])
      -AC_CHECK_DECLS([STATX_TYPE])
      -
      -AC_SUBST([WITH_STATX])
      -AC_ARG_ENABLE([statx],
      +# Check for linux specific statx(2) system call
      +AC_SUBST([HAS_SYSCALL_STATX])
      +AC_ARG_ENABLE([disable_statx],
         [AS_HELP_STRING([--disable-statx], [Do not use linux specific statx(2) system call as replacement for stat(2), lstat(2), and fstat(2)])],
      -  [], [enable_statx="yes"])
      -if test "$enable_statx" = "yes"; then
      -  AC_DEFINE([WITH_STATX], [1], [Use statx system call])
      -  if test "$has_syscall_statx" = "no" && "$have_statx" = "no"; then
      -      AC_MSG_ERROR([statx() and SYS_statx not found, use --disable-statx to not use statx])
      -  fi
      - fi
      +  [enable_syscall_statx="no"],
      +  [enable_syscall_statx=$has_syscall_statx])
      +AM_CONDITIONAL([HAVE_SYSCALL_STATX], [test "$enable_syscall_statx" = "yes"])
      #{'  '}
       # Enable hardened compile and link flags
       AC_ARG_ENABLE([harden_flags],
      diff -Npaur a/Makefile.am b/Makefile.am
      --- a/Makefile.am	2025-07-05 11:50:17.627194694 -0400
      +++ b/Makefile.am	2025-07-05 12:00:16.637833848 -0400
      @@ -81,9 +81,9 @@ src_fuser_SOURCES = \
       		    src/fuser.h \
       		    src/lists.h
      #{' '}
      -#if HAVE_SYSCALL_STATX
      +if HAVE_SYSCALL_STATX
       src_fuser_SOURCES += src/statx.c src/statx.h
      -#endif
      +endif
       src_fuser_LDADD = @LIBINTL@
       src_killall_SOURCES = src/killall.c src/comm.h src/signals.c src/signals.h src/i18n.h
       src_killall_LDADD = @LIBINTL@ @DL_LIB@
    STATX_PATCH_EOF
    system 'patch -Np1 -i statx.patch'
  end
end
