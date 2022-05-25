require 'package'

class Hashpipe < Package
  description 'Hash in a pipe'
  homepage 'https://git.zx2c4.com/hashpipe/about/#hashpipe'
  version '1.0-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.zx2c4.com/hashpipe/snapshot/hashpipe-dc11b6262f4717e61e55760cb2bd637ff1c0f6a9.tar.xz'
  source_sha256 '6b3931d7c46332be2a6c07f94f91924065ba7988edd2e8a471123c77d3c614f6'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hashpipe/1.0-1_armv7l/hashpipe-1.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hashpipe/1.0-1_armv7l/hashpipe-1.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hashpipe/1.0-1_i686/hashpipe-1.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hashpipe/1.0-1_x86_64/hashpipe-1.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c852b3c8c35151b359f94c71505132a865da8bdb710345431b24c46a3ba6931b',
     armv7l: 'c852b3c8c35151b359f94c71505132a865da8bdb710345431b24c46a3ba6931b',
       i686: 'fbb73db66ca7a403b566ffc35522d6853e7130a7b73220d3f475235a17a3220c',
     x86_64: 'e44b2a537d85dfb0667856dd27c14907223767253c95011b1407b606864cb4e4'
  })

  def self.patch
    @hashpipe_patch = <<~HASHPIPE_PATCHEOF
      diff -Npaur orig/hashpipe.c new/hashpipe.c
      --- orig/hashpipe.c	2021-04-08 14:56:27.657272292 -0400
      +++ new/hashpipe.c	2021-04-08 15:11:20.398253126 -0400
      @@ -1,6 +1,7 @@
       /* SPDX-License-Identifier: GPL-2.0
        *
        * Copyright (C) 2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
      + * Code also imported from https://gitlab.gnome.org/GNOME/gtk/-/blob/master/gdk/wayland/cursor/os-compatibility.c
        */

       #define _GNU_SOURCE
      @@ -10,12 +11,59 @@
       #include <stdbool.h>
       #include <unistd.h>
       #include <errno.h>
      +#if defined (__NR_memfd_create)
      +#include <sys/mman.h>
      +#endif
       #include <sys/types.h>
       #include <sys/stat.h>
       #include <sys/sendfile.h>
       #include <fcntl.h>
       #include <openssl/evp.h>

      +#ifndef HAVE_MKOSTEMP
      +static int
      +set_cloexec_or_close(int fd)
      +{
      +	long flags;
      +
      +	if (fd == -1)
      +		return -1;
      +
      +	flags = fcntl(fd, F_GETFD);
      +	if (flags == -1)
      +		goto err;
      +
      +	if (fcntl(fd, F_SETFD, flags | FD_CLOEXEC) == -1)
      +		goto err;
      +
      +	return fd;
      +
      +err:
      +	close(fd);
      +	return -1;
      +}
      +#endif
      +
      +static int
      +create_tmpfile_cloexec(char *tmpname)
      +{
      +	int fd;
      +
      +#ifdef HAVE_MKOSTEMP
      +	fd = mkostemp(tmpname, O_CLOEXEC);
      +	if (fd >= 0)
      +		unlink(tmpname);
      +#else
      +	fd = mkstemp(tmpname);
      +	if (fd >= 0) {
      +		fd = set_cloexec_or_close(fd);
      +		unlink(tmpname);
      +	}
      +#endif
      +
      +	return fd;
      +}
      +
       /* There's a function in OpenSSL for this too, but it's horrible to use. */
       static bool hex2bin(unsigned char *bin, const char *hex, size_t hexlen)
       {
      @@ -51,11 +99,14 @@ static bool hex2bin(unsigned char *bin,

       int main(int argc, char *argv[])
       {
      +	char *name;
       	int fd;
      +	int ret = 0;
       	off_t pos;
       	ssize_t len;
       	size_t hexlen, hashlen, filesize = 0;
      -	const char *hex, *algo, *home;
      +	const char *hex, *algo, *path;
      +	static const char template[] = "/hashpipe-XXXXXX";
       	unsigned char hash[1024], computed_hash[1024], buffer[1024 * 128];
       	const EVP_MD *md;
       	EVP_MD_CTX *mdctx;
      @@ -65,12 +116,57 @@ int main(int argc, char *argv[])
       		return 1;
       	}

      -	home = getenv("HOME");
      -	fd = open(home ? home : "/", O_TMPFILE | O_EXCL | O_RDWR, S_IRUSR | S_IWUSR);
      -	if (fd < 0) {
      -		perror("Error: unable to create temporary inode");
      -		return 1;
      +  #ifdef __NR_memfd_create
      +    fd = memfd_create("hashpipetmp", MFD_CLOEXEC | MFD_ALLOW_SEALING);
      +    if (fd >= 0) {
      +      /* We can add this seal before calling posix_fallocate(), as
      +       * the file is currently zero-sized anyway.
      +       *
      +       * There is also no need to check for the return value, we
      +       * couldn't do anything with it anyway.
      +       */
      +      fcntl(fd, F_ADD_SEALS, F_SEAL_SHRINK | F_SEAL_SEAL);
      +    } else if (fd < 0) {
      +      perror("memfd_create error");
      +      return 1;
      +    }
      +  #endif
      +	{
      +		path = getenv("TMPDIR");
      +		if (!path) {
      +			errno = ENOENT;
      +			path = "/tmp";
      +		}
      +
      +		name = malloc(strlen(path) + sizeof(template));
      +		if (!name)
      +			return -1;
      +
      +		strcpy(name, path);
      +		strcat(name, template);
      +
      +		fd = create_tmpfile_cloexec(name);
      +
      +		free(name);
      +
      +		if (fd < 0)
      +			return -1;
      +	}
      +
      +#ifdef HAVE_POSIX_FALLOCATE
      +	ret = posix_fallocate(fd, 0, filesize);
      +	if (ret != 0) {
      +		close(fd);
      +		errno = ret;
      +		return -1;
      +	}
      +#else
      +	ret = ftruncate(fd, filesize);
      +	if (ret < 0) {
      +		close(fd);
      +		return -1;
       	}
      +#endif

       	algo = argv[1];
       	hex = argv[2];
      @@ -99,7 +195,7 @@ int main(int argc, char *argv[])
       	}
       	while ((len = read(0, buffer, sizeof(buffer))) > 0) {
       		if (write(fd, buffer, len) != len) {
      -			perror("Error: unable to write to temporary inode");
      +			perror("Error: unable to write to temporary location");
       			return 1;
       		}
       		if (!EVP_DigestUpdate(mdctx, buffer, len)) {
      diff -Npaur orig/Makefile new/Makefile
      --- orig/Makefile	2021-04-08 14:57:51.994270482 -0400
      +++ new/Makefile	2021-04-08 14:59:00.199269017 -0400
      @@ -4,7 +4,7 @@ BINDIR ?= $(PREFIX)/bin
       MANDIR ?= $(PREFIX)/share/man

       LDLIBS := -lcrypto
      -CFLAGS ?= -O3 -march=native
      +CFLAGS ?= -O3
       CFLAGS += -std=gnu11 -Wall -pedantic

       all: hashpipe
    HASHPIPE_PATCHEOF
    File.write('hashpipe.patch', @hashpipe_patch, perm: 0o644)
    system 'patch -Np1 -i hashpipe.patch'
  end

  def self.build
    system "make PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make PREFIX=#{CREW_PREFIX} install"
  end
end
