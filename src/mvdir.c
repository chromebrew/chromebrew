/*
  mvdir.c: Move all files under one directory to another,
           override conflict files in the destination directory (merge two directories)

  Usage: ./mvdir [-v] [src] [dst]

  cc ./mvdir.c -O2 -o crew_mvdir
*/

#define _XOPEN_SOURCE 700
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <errno.h>
#include <limits.h>
#include <string.h>
#include <ftw.h>
#include <sys/stat.h>

bool verbose = false;
char src[PATH_MAX], dst[PATH_MAX];
char dirs_to_be_removed[1024][PATH_MAX];
int dirs_to_be_removed_i = 0;

int move_file(const char *path, const struct stat *sb, int flag, struct FTW *ftwbuf) {
  char dst_path[128] = {0};
  strcpy(dst_path, dst);
  strcat(dst_path, "/");
  strcat(dst_path, path);

  if (strcmp(path, ".") == 0) return 0;
  if (verbose) fprintf(stderr, "%s%s -> %s\n", src, path, dst_path);

  switch (flag) {
    case FTW_F:
    case FTW_SL:
      // file/symlink: Move file to dest, override files with same filename in dest (mode/owner remain unchanged)
      if (access(dst_path, F_OK) == 0) {
        if (remove(dst_path) != 0) {
          // remove file with same name in dest (if exist)
          fprintf(stderr, "%s: failed to remove file: %s\n", dst_path, strerror(errno));
          exit(errno);
        }
      }

      // move (rename) file to dest
      if (rename(path, dst_path) != 0) {
        fprintf(stderr, "%s: rename() failed: %s\n", path, strerror(errno));
        exit(errno);
      }

      break;
    case FTW_D:
      // directory
      // create an identical directory in dest (with same permission) if the directory does not exist in dest
      if (access(dst_path, F_OK) != 0) {
        struct stat path_stat;
        stat(path, &path_stat);
        mode_t dir_mode = path_stat.st_mode;

        if (verbose) fprintf(stderr, "Creating directory %s\n", dst_path);
        if (mkdir(dst_path, dir_mode) != 0) {
          fprintf(stderr, "%s: mkdir() failed: %s\n", path, strerror(errno));
          exit(errno);
        }
      }

      // add directory to remove list (will be removed after processing all files in src)
      strcpy(dirs_to_be_removed[dirs_to_be_removed_i++], path);
      break;
    case FTW_NS:
      // error
      fprintf(stderr, "%s: stat failed! (%s)\n", path, strerror(errno));
      exit(errno);
  }
  return 0;
}

int main(int argc, char** argv) {
  int opt;

  while ((opt = getopt(argc, argv, "v")) != -1) {
    switch (opt) {
      case 'v':
        // verbose mode
        verbose = true;
        break;
      default:
        fprintf(stderr, "Usage: %s [-v] [src] [dst]\n", argv[0]);
        exit(EXIT_FAILURE);
        break;
    }
  }

  strcpy(src, argv[optind]);
  strcpy(dst, argv[optind + 1]);

  if (argc - optind != 2) {
    fprintf(stderr, "Usage: %s [-v] [src] [dst]\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  if (chdir(src) != 0) {
    fprintf(stderr, "%s: %s\n", src, strerror(errno));
    exit(errno);
  }

  // call move_file() with files in src recursively
  nftw(".", move_file, 100, FTW_PHYS);

  // remove directories in src
  // reverse list to prevent "Directory not empty" error
  for (int i = (dirs_to_be_removed_i - 1); i >= 0; i--) {
    if (verbose) fprintf(stderr, "Removing directory %s\n", dirs_to_be_removed[i]);

    if (remove(dirs_to_be_removed[i]) != 0) {
      fprintf(stderr, "%s: failed to remove directory: %s\n", dirs_to_be_removed[i], strerror(errno));
      exit(errno);
    }
  }

  return 0;
}