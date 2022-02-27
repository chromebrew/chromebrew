require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '8.9'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable.git'
  git_hashtag 'V_8_9_P1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.9_armv7l/openssh-8.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.9_armv7l/openssh-8.9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.9_i686/openssh-8.9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssh/8.9_x86_64/openssh-8.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c327e76a82e60bd18645d6b2e1f6e1ac3fc55c92dc8964131ec3e8bc4a132797',
     armv7l: 'c327e76a82e60bd18645d6b2e1f6e1ac3fc55c92dc8964131ec3e8bc4a132797',
       i686: 'e391e41838f0c52d5fa0bed31c9bac9cf5c2894df01dad2ca9a656bc0e90838f',
     x86_64: 'be508ee5fbe177b98c39046273c007c6fe6c6375268536fecef33a4966a02237'
  })

  def self.patch
    # Prevent issue with: sorry, unimplemented: ‘-fzero-call-used-regs’ not supported on this target
    # https://salsa.debian.org/ssh-team/openssh/-/blob/master/debian/patches/improve-zero-call-used-regs-detection.patch
    @improve_zero_call_used_regs_detection = <<~'ZERO_CALL_PATCH'
      From de9af8f5d76df77055ba4ad1742c7977c39d3df1 Mon Sep 17 00:00:00 2001
      From: Colin Watson <cjwatson@debian.org>
      Date: Thu, 24 Feb 2022 16:08:48 +0000
      Subject: Improve detection of -fzero-call-used-regs=all support

      Forwarded: https://bugzilla.mindrot.org/show_bug.cgi?id=3394
      Last-Update: 2022-02-24

      Patch-Name: improve-zero-call-used-regs-detection.patch
      ---
       m4/openssh.m4 | 3 +++
       1 file changed, 3 insertions(+)

      diff --git a/m4/openssh.m4 b/m4/openssh.m4
      index 4f9c3792d..8c33c701b 100644
      --- a/m4/openssh.m4
      +++ b/m4/openssh.m4
      @@ -14,6 +14,8 @@ AC_DEFUN([OSSH_CHECK_CFLAG_COMPILE], [{
       	AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
       #include <stdlib.h>
       #include <stdio.h>
      +/* Trivial function to help test for -fzero-call-used-regs */
      +void f(int n) {}
       int main(int argc, char **argv) {
       	(void)argv;
       	/* Some math to catch -ftrapv problems in the toolchain */
      @@ -21,6 +23,7 @@ int main(int argc, char **argv) {
       	float l = i * 2.1;
       	double m = l / 0.5;
       	long long int n = argc * 12345LL, o = 12345LL * (long long int)argc;
      +	f(0);
       	printf("%d %d %d %f %f %lld %lld\n", i, j, k, l, m, n, o);
       	/*
       	 * Test fallthrough behaviour.  clang 10's -Wimplicit-fallthrough does
    ZERO_CALL_PATCH
    File.write('improve-zero-call-used-regs-detection.patch', @improve_zero_call_used_regs_detection)
    system 'patch -Np1 -i improve-zero-call-used-regs-detection.patch'
    # Fix issue with connections on 32-bit architectures
    # https://salsa.debian.org/ssh-team/openssh/-/blob/master/debian/patches/sandbox-ppoll_time64.patch
    @sandbox_ppoll_time64 = <<~'SANDBOX_PPOL_TIME64_PATCH'
      From 37625e373c6d3dcc550fbf715fb54c0e54380143 Mon Sep 17 00:00:00 2001
      From: Patrick McLean <chutzpah@gentoo.org>
      Date: Fri, 25 Feb 2022 23:26:50 +0000
      Subject: Allow ppoll_time64 in seccomp filter

      Origin: other, https://bugzilla.mindrot.org/attachment.cgi?id=3574&action=diff
      Bug: https://bugzilla.mindrot.org/show_bug.cgi?id=3396
      Bug-Debian: https://bugs.debian.org/1006445
      Author: Paul Brook <paul@nowt.org>
      Last-Update: 2022-02-25

      Patch-Name: sandbox-ppoll_time64.patch
      ---
       sandbox-seccomp-filter.c | 3 +++
       1 file changed, 3 insertions(+)

      diff --git a/sandbox-seccomp-filter.c b/sandbox-seccomp-filter.c
      index 2e065ba3e..4ce80cb2a 100644
      --- a/sandbox-seccomp-filter.c
      +++ b/sandbox-seccomp-filter.c
      @@ -276,6 +276,9 @@ static const struct sock_filter preauth_insns[] = {
       #ifdef __NR_ppoll
       	SC_ALLOW(__NR_ppoll),
       #endif
      +#ifdef __NR_ppoll_time64
      +	SC_ALLOW(__NR_ppoll_time64),
      +#endif
       #ifdef __NR_poll
       	SC_ALLOW(__NR_poll),
       #endif
    SANDBOX_PPOL_TIME64_PATCH
    File.write('sandbox-ppoll_time64.patch', @sandbox_ppoll_time64)
    system 'patch -Np1 -i sandbox-ppoll_time64.patch'
  end

  def self.build
    system 'autoreconf -fiv'
    system 'autoheader'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
