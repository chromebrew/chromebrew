# Adapted from Arch Linux crun PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/crun/trunk/PKGBUILD

require 'package'

class Crun < Package
  description 'A fast and lightweight fully featured OCI runtime and C library for running containers'
  homepage 'https://github.com/containers/crun'
  @_ver = '1.7.2'
  version "#{@_ver}-1"
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/containers/crun.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crun/1.7.2-1_armv7l/crun-1.7.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crun/1.7.2-1_armv7l/crun-1.7.2-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crun/1.7.2-1_x86_64/crun-1.7.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '401dc1443e32bf8e4f53542fb08ff18194c1000ead10dca8abba9ae3613f3d07',
     armv7l: '401dc1443e32bf8e4f53542fb08ff18194c1000ead10dca8abba9ae3613f3d07',
     x86_64: '4b03b460ae56fdf34c421a01659bdee53119763670ac794cfde70edd89444b1f'
  })

  depends_on 'criu' if ARCH == 'x86_64'
  depends_on 'glibc' # R
  depends_on 'go_md2man' => :build
  depends_on 'libbpf' => :build
  depends_on 'libcap' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpgerror' # R
  depends_on 'libseccomp' # R
  depends_on 'yajl' # R

  def self.patch
    @crun_patch = <<~'CRUN_PATCH_EOF'
      From 47231d5c516e0cb9c0f51f297d9d67f7533730b4 Mon Sep 17 00:00:00 2001
      From: Giuseppe Scrivano <gscrivan@redhat.com>
      Date: Thu, 12 Jan 2023 21:07:48 +0100
      Subject: [PATCH] cgroup: support cpuset mounted with noprefix

      on cgroup v1, it is possible to pass the "noprefix" option for the
      cpuset mount and that causes the "cpuset." prefix to be dropped from
      the cgroup files.

      To support this case, attempt to open the file without the prefix when
      the cpuset.$FILE version fails with ENOENT.

      Closes: https://github.com/containers/crun/issues/1115

      Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
      ---
       src/libcrun/cgroup-resources.c | 24 ++++++++++++++++++++++--
       src/libcrun/cgroup-setup.c     |  8 ++++++--
       2 files changed, 28 insertions(+), 4 deletions(-)

      diff --git a/src/libcrun/cgroup-resources.c b/src/libcrun/cgroup-resources.c
      index fbb5777a..df7e4882 100644
      --- a/src/libcrun/cgroup-resources.c
      +++ b/src/libcrun/cgroup-resources.c
      @@ -962,14 +962,34 @@ write_cpuset_resources (int dirfd_cpuset, int cgroup2, runtime_spec_schema_confi
             ret = write_file_and_check_controllers_at (cgroup2, dirfd_cpuset, "cpuset.cpus", cpu->cpus, strlen (cpu->cpus),
                                                        err);
             if (UNLIKELY (ret < 0))
      -        return ret;
      +        {
      +          if (! cgroup2 && errno == ENOENT)
      +            {
      +              crun_error_release (err);
      +
      +              ret = write_file_and_check_controllers_at (cgroup2, dirfd_cpuset, "cpus", cpu->cpus, strlen (cpu->cpus),
      +                                                         err);
      +            }
      +          if (UNLIKELY (ret < 0))
      +            return ret;
      +        }
           }
         if (cpu->mems)
           {
             ret = write_file_and_check_controllers_at (cgroup2, dirfd_cpuset, "cpuset.mems", cpu->mems, strlen (cpu->mems),
                                                        err);
             if (UNLIKELY (ret < 0))
      -        return ret;
      +        {
      +          if (! cgroup2 && errno == ENOENT)
      +            {
      +              crun_error_release (err);
      +
      +              ret = write_file_and_check_controllers_at (cgroup2, dirfd_cpuset, "mems", cpu->mems, strlen (cpu->mems),
      +                                                         err);
      +            }
      +          if (UNLIKELY (ret < 0))
      +            return ret;
      +        }
           }
         return 0;
       }
      diff --git a/src/libcrun/cgroup-setup.c b/src/libcrun/cgroup-setup.c
      index b920c70d..8eca7864 100644
      --- a/src/libcrun/cgroup-setup.c
      +++ b/src/libcrun/cgroup-setup.c
      @@ -53,12 +53,14 @@ initialize_cpuset_subsystem_rec (char *path, size_t path_len, char *cpus, char *
         if (cpus[0] == '\0')
           {
             cpus_fd = openat (dirfd, "cpuset.cpus", O_RDWR);
      +      if (UNLIKELY (cpus_fd < 0 && errno == ENOENT))
      +        cpus_fd = openat (dirfd, "cpus", O_RDWR);
             if (UNLIKELY (cpus_fd < 0))
      -        return crun_make_error (err, errno, "open '%s/%s'", path, "cpuset.cpus");
      +        return crun_make_error (err, errno, "open `%s/%s`", path, "cpuset.cpus");

             b_len = TEMP_FAILURE_RETRY (read (cpus_fd, cpus, 256));
             if (UNLIKELY (b_len < 0))
      -        return crun_make_error (err, errno, "read from 'cpuset.cpus'");
      +        return crun_make_error (err, errno, "read from `cpuset.cpus`");
             cpus[b_len] = '\0';
             if (cpus[0] == '\n')
               cpus[0] = '\0';
      @@ -67,6 +69,8 @@ initialize_cpuset_subsystem_rec (char *path, size_t path_len, char *cpus, char *
         if (mems[0] == '\0')
           {
             mems_fd = openat (dirfd, "cpuset.mems", O_RDWR);
      +      if (UNLIKELY (mems_fd < 0 && errno == ENOENT))
      +        mems_fd = openat (dirfd, "mems", O_RDWR);
             if (UNLIKELY (mems_fd < 0))
               return crun_make_error (err, errno, "open '%s/%s'", path, "cpuset.mems");
    CRUN_PATCH_EOF
    File.write('crun.patch', @crun_patch)
    system 'patch -Np1 -i crun.patch'
  end

  def self.build
    @disable_criu = ARCH == 'x86_64' ? '' : '--disable-criu'
    system './autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      #{@disable_criu} \
      --disable-systemd \
      --enable-shared \
      --enable-dynamic \
      --with-python-bindings"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
